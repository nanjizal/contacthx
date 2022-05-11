package contacthx.geom;
@:transitive
@:forward
//@:forwardStatics
abstract Degree( Float ) from Float to Float {
    public inline function new( deg: Float ){
        this = deg;
	}
	@:from
    public static inline function rad2deg( angleRad : Radian ): Degree {
        var v: Float = angleRad;
        var deg: Degree = v / ( Math.PI/180. );
        return deg;
    }
}