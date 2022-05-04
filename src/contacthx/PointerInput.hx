package contacthx;
/**
 *	PointerInput
 * - contains data about one single finger / active pointer
 * - there are "live" parameters and "global" parameters
 * - "live" parameters are caluclated using liveTimespan
 * - "global" parameters are calculated using the whole timespan of this pointerdown
 * - the current vector. The vector should be calculated "live" and not over the whole pointerdown duration. The user expects the pointer input to be in sync with his current finger movement on the screen, not with something a second ago. 
 * - start and end coordinates
 * - start and end timestamps
 * - speeds and distances
 */
 import contacthx.Options;
 import contacthx.geom.VectorStartEnd;
 class PointerInput {
     var options: Options;
     var debug: Bool;
     // TODO: yet to implement
     public function new( pointerdownEvent: PointerEvent, options:Options ) {
         
     }
     public function onIdle(){
 
 
     }
 
     public function onMove( pointermoveEvent: PointerEvent ) {
         
     }
 
     public function onUp( pointerupEvent: PointerEvent ){
 
 
     }
 
     public function onCancel( pointercancelEvent: PointerEvent ){
 
 
     }
 
     public function update( pointerEvent ) {
         
     }
 
     public function getTimedPointerEvents(): PointerEvent {
         return null;
 
     }
 
     public function getVector( startPointerEvent: PointerEvent, endPointEvent: PointerEvent ): VectorStartEnd {
         return null;
     }
 
     public function getSpeed( vector: VectorStartEnd, startTimeStamp: Int, endTimeStamp: Int ): Float {
         return 0.;
     }
 
 }