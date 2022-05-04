package contacthx.gesture;
// TODO: needs more thought
enum abstract Gesture ( String ) from String {
    var Tap          = "Tap";
    var Press        = "Press";
    var Pan          = "Pan";
    var Pinch        = "Pinch";
    var Rotate       = "Rotate";
    var TwoFingerPan = "TwoFingerPan";
}