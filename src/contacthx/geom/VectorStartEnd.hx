package contacthx.geom;
import contacthx.direction.EgocentricCoordinates;
import contacthx.direction.EgocentricCoordinates;
import contacthx.geom.PointXY;

@:structInit
class VectorStartEnd {
    public var start:        PointXY;
    public var end:          PointXY;
    public var direction:    EgocentricCoordinates; 
    public var x:       Float;
    public var y:       Float;
    public var xy:           PointXY;
    public var vectorLength: Float;
    public function new( start: PointXY, end: PointXY ){
        this.start = start;
        this.end   = end;
        x = end.x - start.x;
        y = end.y - start.y;
        xy = { x: x, y: y };
        vectorLength = hypotenuse( x, y );
        direction = calculateDirection();
    }
    private inline function hypotenuse( a: Float, b: Float ): Float {
        return Math.sqrt( Math.pow( a, 2 ) + Math.pow( b, 2 ) );
    }
    private inline function calculateDirection(): EgocentricCoordinates {
        return if( Math.abs ( x ) > Math.abs( y ) ){
            // left or right
            ( start.x < end.x )? RIGHT: LEFT;
        } else {
            // up or down
            ( start.y < end.y )? DOWN: UP;
        }
    }
    public inline function magnitudeNotZero():Bool {
        return vectorLength > 0;
    }
}
