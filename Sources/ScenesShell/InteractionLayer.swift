import Foundation
import Scenes
import Igis

class InteractionLayer : Layer {

<<<<<<< HEAD
    let stars = Stars()
    
    init() {
        super.init(name:"Interaction")
        insert(entity:stars, at:.front)
        stars.changeVelocity(velocityX:3,velocityY:5)
=======
    init() {

        super.init(name:"Interaction")
    }
    func setup(canvasSize:Size, canvas:Canvas) {
        
    }
    func render(canvas:Canvas) {
        
>>>>>>> ee0dc1237c40e2dbeba76fc904786d114ac5f5d9
    }
    
}
