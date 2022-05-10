import Foundation
import Scenes
import Igis

class InteractionLayer : Layer, KeyDownHandler {

    var hasRendered = false

    var hasColored = false
    var red = false
    var green = false
    var yellow = false
    var blue = false 
    var warning = Warning()
    
    var asteroid : [Point] = []
    var asteroidPoint = Point(x:0,y:0)
    var canvasSize = Size(width:0,height:0)
    
    var ship1 : Ships
    var ship2 : Ships
    
    

    var ship1X = 0
    var ship2X = 0
    var ship1Y = 0
    var ship2Y = 0
    var ship1Rotate = 0.0
    var ship2Rotate = 180.0
    var ship1FireVelocity = 6.0
    var ship2FireVelocity = 6.0
    var ship1Color = Color(.white)
    var ship2Color = Color(.white)
    var prevShip1Key = ""
    var prevShip2Key = ""

    let moveAmount = 3.0
    let turnAmount = 3.0
    var timeAmount = "5:00"
    var ship1Lives = 3
    var ship2Lives = 3
    var gameEnded = false
    var gameWin = 0

    let neptuneBackground = NeptuneBackground()
    let mercuryBackground = MercuryBackground()
    let saturnBackground = SaturnBackground()
    let backgroundChoice = ChooseMap()
    //conversion: 30 = 1 second
    let starBackground = StarBackground(waitStar:120,changeStar:120,waitRedGiant:120,changeRedGiant:120,waitSupernova:80,enlargeBlackHole:120,starTargetMultiplier:1.6,redGiantTargetMultiplier:3.0,blackHoleTargetMultiplier:10.0)

    let startingScreen = StartingScreen()
    let player1 = Player1Choose()
    let player2 = Player2Choose()
    let WinnerScreen = winnerScreen()
    let Instructions = instructions()
    var statusBar : StatusBar

    func updateShipPositions() {
        //update ship positions
        ship1.pointX = ship1X
        ship1.pointY = ship1Y
        ship2.pointX = ship2X
        ship2.pointY = ship2Y
        ship1.rotation = ship1Rotate
        ship2.rotation = ship2Rotate
        ship1.color = ship1Color
        ship2.color = ship2Color
    }

    func hasColor(Colored:Bool) {
        if Colored == true  {
            red = true
            yellow = true
            green = true
            blue = true
            hasColored = true
        }
        
    }
        

    func importAsteroids() {
        let asteroidCount = Int.random(in:10 ... 15)
        var safe = false
        var centerX = 0
        var centerY = 0
        var radius = 0
        var renderedAsteroid = Asteroids(centerX:centerX,centerY:centerY,radius:radius,asteroids:asteroid)
        for _ in 1 ... asteroidCount {
            while safe == false {
                centerX = Int.random(in:220 ... canvasSize.width-220)
                centerY = Int.random(in:220 ... canvasSize.height-220)
                radius = Int.random(in:40 ... 100)
                renderedAsteroid = Asteroids(centerX:centerX,centerY:centerY,radius:radius,asteroids:asteroid)
                if renderedAsteroid.boundaries() == true {
                    asteroidPoint = Point(x:centerX,y:centerY)
                    asteroid.append(asteroidPoint)
                    insert(entity:renderedAsteroid, at:.front)
                    safe = true
                }
            }
            safe = false
        }
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
            switch(prevShip1Key) {
            case "forwards": //fire a projectile forwards
                let projectile = Projectile(x:(ship1X + Int(40.0 * cos(ship1Rotate * Double.pi / 180.0))), y:(ship1Y - Int(40.0 * sin(ship1Rotate * Double.pi / 180.0))), degree:ship1Rotate, fireVelocity:ship1FireVelocity, shipColor:Color(.lightblue), ship1X:&ship1X, ship2X:&ship2X, ship1Y:&ship1Y, ship2Y:&ship2Y, p1Lives:&ship1Lives, p2Lives:&ship2Lives)
                insert(entity:projectile, at:.front)
            case "backwards": //fire a projectile backwards
                let projectile = Projectile(x:(ship1X + Int(40.0 * cos(ship1Rotate * Double.pi / 180.0))), y:(ship1Y - Int(40.0 * sin(ship1Rotate * Double.pi / 180.0))), degree:ship1Rotate, fireVelocity:-ship1FireVelocity, shipColor:Color(.lightblue), ship1X:&ship1X, ship2X:&ship2X, ship1Y:&ship1Y, ship2Y:&ship2Y, p1Lives:&ship1Lives, p2Lives:&ship2Lives)
                insert(entity:projectile, at:.front)
            default:
                let projectile = Projectile(x:(ship1X + Int(40.0 * cos(ship1Rotate * Double.pi / 180.0))), y:(ship1Y - Int(40.0 * sin(ship1Rotate * Double.pi / 180.0))), degree:ship1Rotate, fireVelocity:ship1FireVelocity, shipColor:Color(.lightblue), ship1X:&ship1X, ship2X:&ship2X, ship1Y:&ship1Y, ship2Y:&ship2Y, p1Lives:&ship1Lives, p2Lives:&ship2Lives)
                insert(entity:projectile, at:.front)
            }
        case "7": //shoot from ship2
            var projectile : Projectile
            switch(prevShip2Key) {
            case "forwards": //fire a projectile forwards
                projectile = Projectile(x:ship2X + Int(40.0 * cos(ship2Rotate * Double.pi / 180.0)), y:ship2Y - Int(40.0 * sin(ship2Rotate * Double.pi / 180.0)), degree:ship2Rotate, fireVelocity:ship2FireVelocity, shipColor:Color(.lightgreen), ship1X:&ship1X, ship2X:&ship2X, ship1Y:&ship1Y, ship2Y:&ship2Y, p1Lives:&ship1Lives, p2Lives:&ship2Lives)
            case "backwards": //fire a projectile backwards
                projectile = Projectile(x:ship2X + Int(40.0 * cos(ship2Rotate * Double.pi / 180.0)), y:ship2Y - Int(40.0 * sin(ship2Rotate * Double.pi / 180.0)), degree:ship2Rotate, fireVelocity:-ship2FireVelocity, shipColor:Color(.lightgreen), ship1X:&ship1X, ship2X:&ship2X, ship1Y:&ship1Y, ship2Y:&ship2Y, p1Lives:&ship1Lives, p2Lives:&ship2Lives)
            default:
                projectile = Projectile(x:ship2X + Int(40.0 * cos(ship2Rotate * Double.pi / 180.0)), y:ship2Y - Int(40.0 * sin(ship2Rotate * Double.pi / 180.0)), degree:ship2Rotate, fireVelocity:ship2FireVelocity, shipColor:Color(.lightgreen), ship1X:&ship1X, ship2X:&ship2X, ship1Y:&ship1Y, ship2Y:&ship2Y, p1Lives:&ship1Lives, p2Lives:&ship2Lives)
            }
            //link the projectile pointers
            //projectile.linkShipVariables(ship1X:&ship1X, ship2X:&ship2X, ship1Y:&ship1Y, ship2Y:&ship2Y, p1Lives:&ship1Lives, p2Lives:&ship2Lives)
            insert(entity:projectile, at:.front)
            insert(entity:startingScreen, at:.back)
            case "Enter" :
                insert(entity:Instructions, at:.back)
            case "e" :
                insert(entity:ship1, at:.front)
                insert(entity:player1, at:.inFrontOf(object:Instructions))
                insert(entity:ship2, at:.front)
            case "o" :
                if hasColored == false {
                    ship1Color = Color(.blue)
                    blue = true
                    insert(entity:player2, at:.inFrontOf(object:player1))
                }
            case "u" :
                if hasColored == false {
                    ship1Color = Color(.green)
                    green = true
                    insert(entity:player2, at:.inFrontOf(object:player1))
                }
            case "t" :
                if hasColored == false {
                    ship1Color = Color(.red)
                    red = true
                    insert(entity:player2, at:.inFrontOf(object:player1))
                }
            case "v" :
                if hasColored == false { 
                    ship1Color = Color(.yellow)
                    yellow = true
                    insert(entity:player2, at:.inFrontOf(object:player1))
                }
            case "l" :
                if blue == false {
                    ship2Color = Color(.blue)
                    insert(entity:backgroundChoice, at:.inFrontOf(object:player2))
                    warning.terminate = true
                    hasColor(Colored:true) 
                } else {
                    if hasColored == false {
                        insert(entity:warning, at:.front)
                    }
                }
            case "g" :
                if green == false {
                    ship2Color = Color(.green)
                    insert(entity:backgroundChoice, at:.inFrontOf(object:player2))
                    warning.terminate = true
                    hasColor(Colored:true) 
                } else  {
                    if hasColored == false {
                        insert(entity:warning, at:.front)
                    }
                }
                
            case "h" :
                if red == false {
                    ship2Color = Color(.red)
                    insert(entity:backgroundChoice, at:.inFrontOf(object:player2))
                    warning.terminate = true
                    hasColor(Colored:true) 
                } else {
                    if hasColored == false {
                        insert(entity:warning, at:.front)
                    }
                }
                    
            case "k" :
                if yellow == false {
                    ship2Color = Color(.yellow)
                    insert(entity:backgroundChoice, at:.inFrontOf(object:player2))
                    warning.terminate = true
                    hasColor(Colored:true) 
                } else {
                    if hasColored == false {
                        insert(entity:warning, at:.front)
                    }
                }
                
            case "n" :
                if hasRendered == false {
                    insert(entity:neptuneBackground, at:.inFrontOf(object:backgroundChoice))
                    timeAmount = "2:00"
                    insert(entity:statusBar, at:.front)
                    importAsteroids()
                    hasRendered = true
                }
            case "m" :
                if hasRendered == false {
                    insert(entity:mercuryBackground, at:.inFrontOf(object:backgroundChoice))
                    timeAmount = "1:30"
                    insert(entity:statusBar, at:.front)
                    importAsteroids()
                    hasRendered = true 
                }
            case "f" :
                if hasRendered == false {
                    insert(entity:saturnBackground, at:.inFrontOf(object:backgroundChoice))
                    timeAmount = "5:00"
                    insert(entity:statusBar, at:.front)
                    importAsteroids()
                    hasRendered = true 
                }
            case "y" :
                if hasRendered == false {
                    insert(entity:starBackground, at:.inFrontOf(object:backgroundChoice))
                    starBackground.begin()
                    timeAmount = "1:00"
                    insert(entity:statusBar, at:.front)
                    importAsteroids()
                    hasRendered = true 
                }
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
        statusBar = StatusBar(timer:&timeAmount, endVar:&gameEnded, winVar:&gameWin, p1Life:&ship1Lives, p2Life:&ship2Lives)
        ship1 = Ships(PointX:0,PointY:0,rotation:0.0,color:Color(.blue))
        ship2 = Ships(PointX:0,PointY:0,rotation:0.0,color:Color(.green))

        super.init(name:"Interaction")
        
//        insert(entity:ship1, at:.front)
//        insert(entity:ship2, at:.front)
    }
    override func preSetup(canvasSize:Size, canvas:Canvas) {        
        //move ships to starting positions
        ship1X = 60
        ship2X = canvasSize.width - 90
        ship1Y = (canvasSize.height / 2)
        ship2Y = (canvasSize.height / 2)
        updateShipPositions()
        self.canvasSize = canvasSize
        dispatcher.registerKeyDownHandler(handler: self)
        
    }
    override func postTeardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
    }
    
}
