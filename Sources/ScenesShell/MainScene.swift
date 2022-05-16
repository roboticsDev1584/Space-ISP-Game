import Igis
import Scenes

class MainScene : Scene, KeyDownHandler {
    var interactionLayer = InteractionLayer()
    
    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        //tell the game to restart when the user presses "I"
        if (key == "i") {
            remove(layer:interactionLayer)
            interactionLayer = InteractionLayer()
            insert(layer:interactionLayer, at:.front)
        } 
    }
    
    init() {    
        super.init(name:"Main")
        insert(layer:interactionLayer, at:.front)
    }
    override func postSetup(canvasSize:Size, canvas:Canvas) {
        dispatcher.registerKeyDownHandler(handler:self)
    }
    override func postTeardown() {
        dispatcher.unregisterKeyDownHandler(handler:self)
    }
}
