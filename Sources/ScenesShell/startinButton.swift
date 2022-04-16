/*
import Igis
import Scene

class StartingButtonChange : Layer , KeyDownHandler {


    func presetup() {
        dispatcher.registerKeyDownHandler(handler: self)
    }
    
    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        
        print("key:\(key)")
        if key == "↵" {
            changeR -= 10
            InteractionLayer.paddleRight.move(to:Point(x:1880, y:changeR))
        }
        
    }

    func postTeardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
    }
}

 */
