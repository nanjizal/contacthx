package contacthx;
import contacthx.geom.VectorStartEnd;

@:StructInit
class MultipointerParameters {
    public var centerMovement:         Float;
    public var centerMovementVector:   VectorStartEnd;
    public var distanceChange:         Float;
    public var relativeDistanceChange: Float;
    public var rotationAngle:          Float;
    public var vectorAngle:            Float;
    public function new( centerMovement:         Float
                       , centerMovementVector:   VectorStartEnd
                       , distanceChange:         Float
                       , relativeDistanceChange: Float
                       , rotationAngle:          Float
                       , vectorAngle:            Float
                        ){
        this.centerMovement         = centerMovement;
        this.centerMovementVector   = centerMovementVector;
        this.distanceChange         = distanceChange;
        this.relativeDistanceChange = relativeDistanceChange;
        this.rotationAngle          = rotationAngle;
        this.vectorAngle            = vectorAngle;
    }
}
