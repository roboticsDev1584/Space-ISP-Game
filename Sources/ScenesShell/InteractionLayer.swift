import Foundation
import Scenes
import Igis

class InteractionLayer : Layer, KeyDownHandler {

    var ship1 = Ships(PointX:0,PointY:0,rotation:0.0,color:Color(.blue))
    var ship2 = Ships(PointX:0,PointY:0,rotation:0.0,color:Color(.green))
    
    var ship1X = 0
    var ship2X = 0
    var ship1Y = 0
    var ship2Y = 0
    var ship1Rotate = 0.0
    var ship2Rotate = 180.0
    var ship1FireVelocity = 3.0
    var ship2FireVelocity = 3.0
    var prevShip1Key = ""
    var prevShip2Key = ""
    let moveAmount = 3.0
    let turnAmount = 3.0

    let neptuneBackground = NeptuneBackground()
    let mercuryBackground = MercuryBackground()
    let saturnBackground = SaturnBackground()
    let backgroundChoice = ChooseMap()
    //conversion: 30 = 1 second
    let starBackground = StarBackground(waitStar:90,changeStar:90,waitRedGiant:90,changeRedGiant:90,waitSupernova:60,enlargeBlackHole:90,starTargetMultiplier:1.6,redGiantTargetMultiplier:3.0,blackHoleTargetMultiplier:10.0)

    let startingScreen = StartingScreen()
    let player1 = Player1Choose()
    let player2 = Player2Choose()
    let WinnerScreen = winnerScreen()
    let statusBar = StatusBar()
    let Instructions = instructions()
    func updateShipPositions() {
        //update ship positions
        ship1.pointX = ship1X
        ship1.pointY = ship1Y
        ship2.pointX = ship2X
        ship2.pointY = ship2Y
        ship1.rotation = ship1Rotate
        ship2.rotation = ship2Rotate
    }
    //update the ship1X and ship1Y values
    func moveShip1(moveX:Double, moveY:Double) {
        ship1X += Int(moveX * cos(ship1Rotate * Double.pi / 180.0))
        ship1Y -= Int(moveY * sin(ship1Rotate * Double.pi / 180.0))
    }
    //update the ship2X and ship2Y values
    func moveShip2(moveX:Double, moveY:Double) {
        ship2X += Int(moveX * cos(ship2Rotate * Double.pi / 180.0))
        ship2Y -= Int(moveY * sin(ship2Rotate * Double.pi / 180.0))
    }
    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        switch(key) {
        case "8": //move ship2 forwards
            moveShip2(moveX:moveAmount, moveY:moveAmount)
            prevShip2Key = "forwards"
        case "5": //move ship2 backwards
            moveShip2(moveX:-moveAmount, moveY:-moveAmount)
            prevShip2Key = "backwards"
        case "6": //turn ship2 right
            ship2Rotate -= turnAmount
            prevShip2Key = "right"
        case "4": //turn ship2 left
            ship2Rotate += turnAmount
            prevShip2Key = "left"
        case "w": //move ship1 forwards
            moveShip1(moveX:moveAmount, moveY:moveAmount)
            prevShip1Key = "forwards"
        case "s": //move ship1 backwards
            moveShip1(moveX:-moveAmount, moveY:-moveAmount)
            prevShip1Key = "backwards"
        case "d": //turn ship1 right
            ship1Rotate -= turnAmount
            prevShip1Key = "right"
        case "a": //turn ship1 left
            ship1Rotate += turnAmount
            prevShip1Key = "left"
        case "r": //shoot from ship
            let projectile : Projectile
            switch(prevShip1Key) {
            case "forwards": //fire a projectile forwards
                projectile = Projectile(x:(ship1X + Int(40.0 * cos(ship1Rotate * Double.pi / 180.0))), y:(ship1Y - Int(40.0 * sin(ship1Rotate * Double.pi / 180.0))), degree:ship1Rotate, fireVelocity:ship1FireVelocity, shipColor:Color(.lightblue))
            case "backwards": //fire a projectile backwards
                projectile = Projectile(x:(ship1X + Int(40.0 * cos(ship1Rotate * Double.pi / 180.0))), y:(ship1Y - Int(40.0 * sin(ship1Rotate * Double.pi / 180.0))), degree:ship1Rotate, fireVelocity:-ship1FireVelocity, shipColor:Color(.lightblue))
            default:
                projectile = Projectile(x:(ship1X + Int(40.0 * cos(ship1Rotate * Double.pi / 180.0))), y:(ship1Y - Int(40.0 * sin(ship1Rotate * Double.pi / 180.0))), degree:ship1Rotate, fireVelocity:ship1FireVelocity, shipColor:Color(.lightblue))
            }
            insert(entity:projectile, at:.front)
        case "7": //shoot from ship2
            let projectile : Projectile
            switch(prevShip2Key) {
            case "forwards": //fire a projectile forwards
                projectile = Projectile(x:ship2X + Int(40.0 * cos(ship2Rotate * Double.pi / 180.0)), y:ship2Y - Int(40.0 * sin(ship2Rotate * Double.pi / 180.0)), degree:ship2Rotate, fireVelocity:ship2FireVelocity, shipColor:Color(.lightgreen))
            case "backwards": //fire a projectile backwards
                projectile = Projectile(x:ship2X + Int(40.0 * cos(ship2Rotate * Double.pi / 180.0)), y:ship2Y - Int(40.0 * sin(ship2Rotate * Double.pi / 180.0)), degree:ship2Rotate, fireVelocity:-ship2FireVelocity, shipColor:Color(.lightgreen))
            default:
                projectile = Projectile(x:ship2X + Int(40.0 * cos(ship2Rotate * Double.pi / 180.0)), y:ship2Y - Int(40.0 * sin(ship2Rotate * Double.pi / 180.0)), degree:ship2Rotate, fireVelocity:ship2FireVelocity, shipColor:Color(.lightgreen))
            }
            insert(entity:projectile, at:.front)
            insert(entity:startingScreen, at:.back)
            case "Enter" :
                insert(entity:Instructions, at:.back)
            case "e" :
                insert(entity:player1, at:.inFrontOf(object:Instructions))
            case "x" :
                insert(entity:player2, at:.inFrontOf(object:player1))
            case "l" :
                insert(entity:backgroundChoice, at:.inFrontOf(object:player2))
            case "n" :
                insert(entity:neptuneBackground, at:.inFrontOf(object:backgroundChoice))
                insert(entity:statusBar, at:.front)
            case "m" :
                insert(entity:mercuryBackground, at:.inFrontOf(object:backgroundChoice))
                insert(entity:statusBar, at:.front)
            case "f" :
                insert(entity:saturnBackground, at:.inFrontOf(object:backgroundChoice))
                insert(entity:statusBar, at:.front)
            case "y" :
                insert(entity:starBackground, at:.inFrontOf(object:backgroundChoice))
                starBackground.begin()
                insert(entity:statusBar, at:.front)
            case "q" :
                insert(entity:WinnerScreen, at:.inFrontOf(object:starBackground))
            default:
                break
        }
        if (ship1Rotate < 0.0) {
            ship1Rotate += 360.0
        }
        else if (ship1Rotate >= 360.0) {
            ship1Rotate -= 360.0
        }
        if (ship2Rotate < 0.0) {
            ship2Rotate += 360.0
        }
        else if (ship2Rotate >= 360.0) {
            ship2Rotate -= 360.0
        }
        updateShipPositions()
    }
    
    init() {
        super.init(name:"Interaction")

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
        updateShipPositions()
        
        dispatcher.registerKeyDownHandler(handler: self)
    }
    override func postTeardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
    }
    
}
