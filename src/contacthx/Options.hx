package contacthx;

import contacthx.PointerFunction;
import contacthx.gesture.Gestures;

@:StructInit
class Options {
    // TODO: work out how to implement
    /**
     * supportedGestures 	Array[]
     * items can be gesture classes or instances of gesture classes 
     */
    public var supportedGestures: Array<Gestures>;
    /**
     *  Turn event bubbling on or off. 
     */
    public var bubbles:           Bool;
    /**
     * Let PointerListener block default TouchEvents which might interfere with PointerEvents. 
     */
    public var handleTouchEvents: Bool;

    public var pointerDown:       PointerFunction;
    public var pointerMove:       PointerFunction;
    public var pointerUp:         PointerFunction;
    public var pointerOut:        PointerFunction;
    public var pointerCancel:     PointerFunction;
    /**
     * Show console output of the PointerListener instance. 
     */
    public var DEBUG:             Bool;
    /**
     * Show console output of the Gesture instances. Displays the recognition process.
     */
    public var DEBUG_GESTURES:    Bool;
    /**
     * Show console output of the Contact and PointerInput instances. Displays information about vectors and collected data.
     */
    public var DEBUG_CONTACT:     Bool;	

    public function new( supportedGestures: Array<Gestures>
                       , bubbles:           Bool = false
                       , handTouchEvents:   Bool = false
                       , pointerDown:       PointerFunction = null
                       , pointerMove:       PointerFunction = null
                       , pointerUp:         PointerFunction = null
                       , pointerOut:        PointerFunction = null
                       , pointerCancel:     PointerFunction = null
                       , DEBUG:             Bool = false
                       , DEBUG_GESTURES:    Bool = false
                       , DEBUG_CONTACT:     Bool = false ){
        this.supportedGestures = Array<Gestures>;
        this.bubbles           = bubbles;
        this.handleTouchEvents = handTouchEvents;
        this.pointerDown       = pointerDown;
        this.pointerMouse      = pointerMouse;
        this.pointerMove       = pointerMove;
        this.pointerUp         = pointerUp;
        this.pointerOut        = pointerOut;
        this.pointerUp         = pointerUp;
        this.pointerCancel     = pointerCancel;
        this.DEBUG             = DEBUG;
        this.DEBUG_CONTACT     = DEBUG_CONTACT;
        this.DEBUG_GESTURES    = DEBUG_GESTURES;
    }
}
