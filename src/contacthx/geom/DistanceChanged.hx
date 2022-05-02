package contacthx.geom;

@:StructInit
class DistanceChange {
    public var absolute: Float;
    public var relative: Float;
    public function new( absolute: Float, relative: Float ){
        this.absolute = absolute;
        this.relative = relative;
    }
}
