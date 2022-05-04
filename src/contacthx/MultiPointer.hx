package contacthx;
import contacthx.MultipointParameters;

@:StructInit
class MultiPointer {
    public var liveParameter:   MultipointerParameters;
    public var globalParameter: MultipointerParameters;
    public function new( liveParameter:   MultipointerParameters
                       , globalParameter: MultipointerParameters ){
        this.liveParameter   = liveParameter;
        this.globalParameter = globalParameter;
    }
}
