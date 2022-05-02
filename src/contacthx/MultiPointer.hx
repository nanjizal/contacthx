package contacthx;
import contacthx.MultiPointerParameters;

@:StructInit
class MultiPointer {
    public var liveParameter:   MultiPointerParameters;
    public var globalParameter: MultiPointerParameters;
    public function new( liveParameter:   MultiPointerParameters
                       , globalParameter: MultiPointerParameters ){
        this.liveParameter   = liveParameter;
        this.globalParameter = globalParameter;
    }
}
