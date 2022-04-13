import Foundation
import Scenes
import Igis

class InteractionLayer : Layer {

    let stars = Stars()
    
    init() {
        super.init(name:"Interaction")
        insert(entity:stars, at:.front)
        stars.changeVelocity(velocityX:3,velocityY:5)
    }
    
}
