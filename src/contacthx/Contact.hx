package contacthx;

import haxe.display.Display.PositionParams;
import contacthx.MultiPointer;
import haxe.ds.HashMap;
import contacthx.geom.DistanceChanged;
import haxe.ds.IntMap;
import contacthx.geom.Radian;
import contacthx.geom.Degree;
import contacthx.geom.VectorStartEnd;
import contacthx.geom.PointXY;

class ContactHX{
    var options: Options;//HashMap<>;
    var pointerInputs = new IntMap<PointerInput>();
    var debug: Bool;
    var id: Float;
    var activePointerInputs = new IntMap<PointerInput>();
    var primaryPointerId: Int;
    var initialPointerEvent: PointerEvent;
    var currentPointerEvent: PointerEvent;
    var isActive: Bool;
    // consider https://api.haxe.org/haxe/Timer.html
    var startTimestamp: Float;
    var currentTimestamp: Float;
    var endTimestamp: Float;
    var multipointer: MultiPointer;

    public function new( pointerDownEvent: PointerEvent, options: Options ) {
        if( options == null ){

        }
        id = Date.now().getTime();
        startTimestamp = pointerDownEvent.timeStamp;
        currentTimestamp = startTimestamp;
        addPointer( pointerDownEvent );

        //multipointer = { liveParameters : {}, globalParameters: {} };
            /*
				centerMovement : null,
				centerMovementVector : null,
				distanceChange : null, // px
				relativeDistanceChange : null, // %
				rotationAngle : null, //deg ccw[0,360], cw[0,-360] 
				vectorAngle : null // angle between the 2 vectors performed by the pointer. This differs from rotationAngle
			},
			globalParameters : {
				centerMovement : null,
				centerMovementVector : null,
				distanceChange : null,
				relativeDistanceChange: null,
				rotationAngle : null,
				vectorAngle : null
			}*/
		//};
    }

    // TODO: 
    public function addPointer( pointerdownEvent: PointerEvent ) {
        currentPointerEvent = pointerdownEvent;

        //var pointerInput = [ pointerdownEvent.pointerId ] = pointerInputs;

    }
    
    public function removePointer( pointerId: Int ){
        if( activePointerInputs.exists( pointerId) ) activePointerInputs.remove( pointerId );
    }

    public function getPointerIntput( pointerId: Int ): Null<PointerInput> {
        return if( activePointerInputs.exists( pointerId ) ){
            activePointerInputs.get( pointerId );
        } else {
            var id = pointerId;
            /*throw new haxe.Exception*/
            trace("invalid pointerId: $id. Pointer not found in Contact.pointers");
            null;
        }
    }

    public function getPrimaryPointerInput(): PointerInput {
        return activePointerInputs.get( primaryPointerId );
    }

    public function getMultiPointerInputs( no: Int = 2 ): Array<PointerInput> {
        if( no < 2 ) return [];
        var keys = pointerInputs.keys();
        var len = -1;
        for( l in keys ) len++;
        if( len < 2 ) return [];
        keys = pointerInputs.keys();
        var multiPointInputs = [];
        if( len < no ){
            for( i in keys ){
                //TODO: consider order of extraction
                multiPointInputs[i] = pointerInputs.get(i);
            }
        }
        return multiPointInputs;
    }
    
    public function onPointerMove( pointerMoveEvent: PointerEvent ){
        currentPointerEvent = pointerMoveEvent;
        currentTimestamp    = pointerMoveEvent.timeStamp;
        var movedPointer    = pointerInputs.get( pointerMoveEvent.pointerId );
        movedPointer.onMove( pointerMoveEvent );
        if( debug ) trace(this.pointerInputs);
        updateState();
    }
    /**
     * pointerup event: finger released, or mouse button released
     **/
    public function onPointerUp( pointerUpEvent: PointerEvent ){
        var pointerId       = pointerUpEvent.pointerId;
        currentPointerEvent = pointerUpEvent;
        currentTimestamp    = pointerUpEvent.timeStamp;
        var removedPointer  = pointerInputs.get( pointerId );
        removedPointer.onUp( pointerUpEvent );
        removePointer( pointerId );
        updateState();
    }

    public function onPointerCancel( pointerCancelEvent: PointerEvent ){
        onPointerUp( pointerCancelEvent );
        if( debug ) trace("[Contact] pointercancel detected");
    }
	// also covers pointerleave
	// not necessary - using element.setPointerCapture and element.releasePointerCapture instead
    public function onPointerLeave( pointerLeaveEvent: PointerEvent ){
        onPointerUp( pointerLeaveEvent );
        if( debug ) trace("[Contact] pointerleave detected");
    }

	// if the contact idles (no Momvement), the time still passes
	// therefore, the pointerInput has to be updated
    public function onIdle(){
        for( id in activePointerInputs.keys() ) activePointerInputs.get( id ).onIdle();
    }

    public function updateState():Void{
        // TODO:
        return;
    }

    public function updateMultiPointerParameters():Void{
        // TODO:
        return;
    }

    public function calculateCenterMovement( v1: VectorStartEnd, v2: VectorStartEnd ): VectorStartEnd {
        // start point is the center between the starting points of the 2 vectors, center between the end points of the vectors
        return new VectorStartEnd( PointXY.getCenter( v1.start, v2.start )
                                 , PointXY.getCenter( v1.end, v2.end )
                                 );
    }

    public function calculateDistanceChange( v1: VectorStartEnd, v2: VectorStartEnd ): DistanceChange {
        // vector between	
        var vStart = new VectorStartEnd( v1.start, v2.start );
        var vEnd   = new VectorStartEnd( v1.end  , v2.end   );
        return { 
            absolute : vEnd.vectorLength - vStart.vectorLength,
            relative : vEnd.vectorLength / vStart.vectorLength
        }
    }
	/*
	* CALCULATE ROTATION
	* this is not a trivial problem
	* required output is: angle and direction (cw //ccw)
	* direction is relative to the first touch with two fingers, not absolute to the screens default coordinate system
	* to determine rotation direction, 3 points on the circle - with timestamps - are required
	* imagine a steering wheel
	* - initial state is 0 deg (0)
	* - if the wheel has been turned ccw, its state has a negative angle
	* - if the wheel has been turned cw, its state has a positive angle
	* - possible values for the angle: [-360,360]
	*/
    // TODO: likely can by simplified
    public function calculateRotationAngle( v1: VectorStartEnd, v2: VectorStartEnd ): Degree {
        // vector_ are vectors between 2 points in time, same finger
        // angleVector_ are vectors between 2 fingers
        var angleVector1: VectorStartEnd = { start: v1.start, end: v2.start }; // in time: occured first
        var angleVector2: VectorStartEnd = { start: v1.end,   end: v2.end   }; // in time: occured second
        var origin: PointXY = { x: 0, y: 0 };
		// translate the points of the vector, so that their startPoints are attached to (0,0)
		/*
		
						^
					   /
					  /
					 /	
					x	
					0			

		*/
        var translationVector1: VectorStartEnd = { start: angleVector1.start, end: origin };
        var translatedEndPoint1 = angleVector1.end.translatePoint( translationVector1 );
            
        //var v_1_translated = new Vector(origin, translatedEndPoint_1);

        var translationVector2: VectorStartEnd = { start: angleVector2.start, end: origin };
        var translatedEndPoint2 = angleVector2.end.translatePoint( translationVector2 );
                  
        //var v2_translated = new Vector(origin, translatedEndPoint_2);
            
            
		// rotate the first angle vector so its y-coordinate becomes 0
		/*
				
				x------->
				0
				
		*/
        var rotationAngle = -1*translatedEndPoint1.calcAngleRad();
        
        // rotation matrix
        //var x_1_rotated =  ( translatedEndPoint_1.x * Math.cos(rotationAngle) ) - ( translatedEndPoint_1.y * Math.sin(rotationAngle) );
        //var y_1_rotated = Math.round(( translatedEndPoint_1.x * Math.sin(rotationAngle) ) + ( translatedEndPoint_1.y * Math.cos(rotationAngle) )); // should be 0

        //var v_1_rotated = new Vector(origin, new Point(x_1_rotated, y_1_rotated));
        
        // rotate the second vector (in time: after 1st)
        var x_2_rotated =  ( translatedEndPoint2.x * Math.cos( rotationAngle ) ) - ( translatedEndPoint2.y * Math.sin( rotationAngle ) );
        var y_2_rotated = Math.round(( translatedEndPoint2.x * Math.sin( rotationAngle ) ) + ( translatedEndPoint2.y * Math.cos( rotationAngle ) ));
        
        //var v_2_rotated = new Vector(origin, new Point(x_2_rotated, y_2_rotated));

        // calculate the angle between v_1 and v_2
  // Was...
        //var angleDeg: Degree = Math.atan2( y_2_rotated, x_2_rotated ) * 180 / Math.PI;
        var angleRad: Radian = Math.atan2( y_2_rotated, x_2_rotated );
        var angleDeg: Degree = angleRad; // conversion
        return angleDeg;
    }

    public function calculateVectorAngle( v1: VectorStartEnd, v2: VectorStartEnd ): Degree {
        var angleDeg: Degree = null;  /// 0 ???
        if( v1.magnitudeNotZero() && v2.magnitudeNotZero() ){
            var cos = ( ( v1.x*v2.x ) + ( v1.y*v2.y ) ) / ( v1.vectorLength * v2.vectorLength );
            var angleRad: Radian = Math.acos( cos );
            angleDeg = angleRad; // conversion
        }
        return angleDeg;
    }
}