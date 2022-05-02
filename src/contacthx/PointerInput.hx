package contacthx;
/**
 *	PointerInput
 * - contains data about one single finger / active pointer
 * - there are "live" parameters and "global" parameters
 * - "live" parameters are caluclated using liveTimespan
 * - "global" parameters are calculated using the whole timespan of this pointerdown
 * - the current vector. The vector should be calculated "live" and not over the whole pointerdown duration. The user expects the pointer input to be in sync with his current finger movement on the screen, not with something a second ago. 
 * - start and end coordinates
 * - start and end timestamps
 * - speeds and distances
 */
class PointerInput {
    var options: ;
    var debug: Bool;
    var 
    public function new( pointerdownEvent, options ) {
        
    }
    public function onIdle(){


    }

    public function onMove( pointermoveEvent ) {
        
    }

    public function onUp( pointerupEvent ){


    }

    public function onCancel( pointercancelEvent ){


    }

    public function update( pointerEvent ) {
        
    }

    public function getTimedPointerEvents(): PointerEvents {


    }

    public function getVector( startPointerEvent, endPointEvent ): VectorStartEnd {
        
    }

    public function getSpeed( vector: VectorStartEnd, startTimeStamp: Int, endTimeStamp: Int ): Float {
        
    }



}
