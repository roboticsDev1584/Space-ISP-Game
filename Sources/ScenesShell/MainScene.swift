import Igis
import Scenes

class MainScene : Scene, KeyDownHandler {
    //initialize interaction layer
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
        //insert interaction layer at the front
        insert(layer:interactionLayer, at:.front)
    }

    //set up key down handler
    override func postSetup(canvasSize:Size, canvas:Canvas) {
        dispatcher.registerKeyDownHandler(handler:self)
    }

    //teardown key down handler
    override func postTeardown() {
        dispatcher.unregisterKeyDownHandler(handler:self)
    }
}
