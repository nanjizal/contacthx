package contacthx.geom;
@:transitive
@:forward
//@:forwardStatics
abstract Radian( Float ) from Float to Float {
	public inline function new( rad: Float ){
		this = rad;
	}
	@:from
	public static inline function deg2rad( angleDeg: Degree ): Radian {
		var v: Float = angleDeg;
		var ratio: Float = (Math.PI/180.);
		var rad: Radian = v * ratio; 
		return rad;
	}
}