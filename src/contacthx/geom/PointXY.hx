package contacthx.geom;

@:structInit
class PointXY {
    public var x: Float;
    public var y: Float;
    public function new( x: Float, y: Float ){
        this.x = x;
        this.y = y;
    }
    // return the counter-clockwise angle between the positive x-axis and a point.
    // from 0 degrees to 360 degrees
    // see https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/atan2
    public inline function calcAngleDegrees(): Float {
        // angle in degrees between -180 and 180
        var angle = Math.atan2( y, x ) * 180 / Math.PI;
        if( angle < 0 ) angle = 360 + angle;
        return angle; 
    }

    public inline function calcAngleRad(): Float {
        var angle = Math.atan2( y, x ); // [-PI, PI]
        if( angle < 0 ) angle = 2 * Math.PI + angle;
        return angle;
    }

    public inline function translatePoint( v: VectorStartEnd ): PointXY {
        return new PointXY( x + v.xy.x, y + v.xy.y );
    }
    
    public static inline function getCenter( a: PointXY, b: PointXY ): PointXY {
        var center = new PointXY( ( a.x + b.x) / 2
                                , ( a.y + b.y) / 2 );
        return center;
    }
}
