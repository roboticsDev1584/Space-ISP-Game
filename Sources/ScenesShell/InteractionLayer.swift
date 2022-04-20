import Foundation
import Scenes
import Igis

class InteractionLayer : Layer, KeyDownHandler {

    var ship1X = 0
    var ship2X = 0
    var ship1Y = 0
    var ship2Y = 0
    var prevShip1Key = ""
    var prevShip2Key = ""
    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        switch(key) {
        case "ArrowUp": //move ship2 up
            ship2Y -= 3
            prevShip2Key = "up"
        case "ArrowDown": //move ship2 down
            ship2Y += 3
            prevShip2Key = "down"
        case "ArrowRight": //move ship2 right
            ship2X += 3
            prevShip2Key = "right"
        case "ArrowLeft": //move ship2 left
            ship2X -= 3
            prevShip2Key = "left"
        case "w": //move ship1 up
            ship1Y -= 3
            prevShip1Key = "up"
        case "s": //move ship1 down
            ship1Y += 3
            prevShip1Key = "down"
        case "d": //move ship1 right
            ship1X += 3
            prevShip1Key = "right"
        case "a": //move ship1 left
            ship1X -= 3
            prevShip1Key = "left"
        case "r": //shoot from ship1
            let projectile : Projectile
            switch(prevShip1Key) {
            case "up": //fire a projectile up
                projectile = Projectile(x:ship1X, y:ship1Y, degree:270, fireVelocity:3)
            case "down": //fire a projectile down
                projectile = Projectile(x:ship1X, y:ship1Y, degree:90, fireVelocity:3)
            case "right": //fire a projectile right
                projectile = Projectile(x:ship1X, y:ship1Y, degree:0, fireVelocity:3)
            case "left": //fire a projectile left
                projectile = Projectile(x:ship1X, y:ship1Y, degree:180, fireVelocity:3)
            default:
                projectile = Projectile(x:ship1X, y:ship1Y, degree:180, fireVelocity:3)
            }
            insert(entity:projectile, at:.front)
        case "/": //shoot from ship2
            let projectile : Projectile
            switch(prevShip2Key) {
            case "up": //fire a projectile up
                projectile = Projectile(x:ship1X, y:ship1Y, degree:270, fireVelocity:3)
            case "down": //fire a projectile down
                projectile = Projectile(x:ship1X, y:ship1Y, degree:90, fireVelocity:3)
            case "right": //fire a projectile right
                projectile = Projectile(x:ship1X, y:ship1Y, degree:0, fireVelocity:3)
            case "left": //fire a projectile left
                projectile = Projectile(x:ship1X, y:ship1Y, degree:180, fireVelocity:3)
            default:
                projectile = Projectile(x:ship1X, y:ship1Y, degree:180, fireVelocity:3)
            }
            insert(entity:projectile, at:.front)
        default:
                break
        }
        //ship1.move(x:ship1X,y:ship1Y)
        //ship2.move(x:ship2X,y:ship2Y)
    }
    
    init() {
        super.init(name:"Interaction")


        //insert star object
        let ship1 = Ships(PointX:500,PointY:300,rotation:45.0,color:Color(.blue))
        let ship2 = Ships(PointX:700,PointY:300,rotation:0.0,color:Color(.green))
        //initialize ship objects
        //insert ship objects
        insert(entity:ship1, at:.front)
        insert(entity:ship2, at:.front)
    }
    override func preSetup(canvasSize:Size, canvas:Canvas) {        
        //move ships to starting positions
        ship1X = 60
        ship2X = canvasSize.width - 90
        ship1Y = (canvasSize.height / 2)
        ship2Y = (canvasSize.height / 2)
        //ship1.move(x:ship1X,y:ship1Y)
        //ship2.move(x:ship2X,y:ship2Y)
        
        dispatcher.registerKeyDownHandler(handler: self)
    }
    override func postTeardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
    }
    
}
