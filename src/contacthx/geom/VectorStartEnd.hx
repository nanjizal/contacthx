package contacthx.geom;
import contacthx.direction.EgocentricCoordinates;
import contacthx.direction.EgocentricCoordinates;
import contacthx.geom.PointXY;

@:StructInit
class VectorStartEnd {
    public var start:        PointXY;
    public var end:          PointXY;
    public var direction:    EgocentricCoordinates; 
    public var deltaX:       Float;
    public var deltaY:       Float;
    public var xy:           PointXY;
    public var vectorLength: Float;
    public function new( start: PointXY, end: PointXY ){
        this.start = start;
        this.end   = end;
        deltaX = end.x - start.x;
        deltaY = end.y - start.y;
        xy = { deltaX, deltaY };
        vectorLength = hypotenuse( deltaX, deltaY );
        direction = calculateDirection();
    }
    private inline function hypotenuse( a: Float, b: Float ): Float {
        return Math.sqrt( Math.pow( a, 2 ) + Math.pow( b, 2 ) );
    }
    private inline function calculateDirection(): EgocentricCoordinates {
        retun if( Math.abs (deltaX ) > Math.abs( deltaY ) ){
            // left or right
            ( start.x < end.x )? RIGHT: LEFT;
         else {
            // up or down
            ( start.y < end.y )? DOWN: UP;
        }
    }
}
