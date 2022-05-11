package contacthx.geom;

@:structInit
class DistanceChange {
    public var absolute: Float;
    public var relative: Float;
    public function new( absolute: Float, relative: Float ){
        this.absolute = absolute;
        this.relative = relative;
    }
}
