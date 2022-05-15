import Foundation
import Scenes
import Igis

class InteractionLayer : Layer, KeyDownHandler, MouseMoveHandler, MouseDownHandler {
    var hasRendered = false

    var hasColored = false
    var colored1 = false //shows if p1 has chosen a color
    var hasEntered = false //shows if enter has been pressed on start screen
    var hasInstructions = false //shows if e has been pressed on instructions screen
    var red = false
    var green = false
    var yellow = false
    var blue = false 
    var warning = Warning()
    
    var asteroid : [Point] = []
    var asteroidRects : [Rect] = []
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
    var ship1FireVelocity = 5.0
    var ship2FireVelocity = 5.0
    var ship1Color = Color(.white)
    var ship2Color = Color(.white)
    var prevShip1Key = ""
    var prevShip2Key = ""

    let moveAmount = 5.0
    let turnAmount = 3.0
    var timeAmount = "5:00"
    var ship1Lives = 3
    var ship2Lives = 3
    var blackHoleStrength = 0
    var gameEnded = false
    var gameWin = 0
    var projectiles : [Projectile] = []

    let neptuneBackground = NeptuneBackground()
    let mercuryBackground = MercuryBackground()
    let saturnBackground = SaturnBackground()
    let backgroundChoice = ChooseMap()
    //conversion: 30 = 1 second
    var starBackground : StarBackground

    let startingScreen = StartingScreen()
    let player1 = Player1Choose()
    let player2 = Player2Choose()
    let Instructions = instructions()
    var statusBar : StatusBar
    var winnerScreen : WinnerScreen

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
        //cannot be too high of an asteroid count or it takes too long to find a safe place to render more asteroids, anything above 5 is too high
        let asteroidCount = Int.random(in:3 ... 5)
        var safe = false
        var centerX = 0
        var centerY = 0
        var radius = 0
        for _ in 1 ... asteroidCount {
            safe = false
            while safe == false {
                centerX = Int.random(in:canvasSize.center.x-400 ... canvasSize.center.x+400)
                centerY = Int.random(in:canvasSize.center.y-300 ... canvasSize.center.y+300)
                radius = Int.random(in:40 ... 100)
                let renderedAsteroid = Asteroids(centerX:centerX,centerY:centerY,radius:radius,asteroids:asteroid)
                if renderedAsteroid.boundaries() == true {
                    asteroidPoint = Point(x:centerX,y:centerY)
                    asteroid.append(asteroidPoint)
                    //appends the bounding rect of the asteroid to the asteroid array for containment
                    asteroidRects.append(Rect(topLeft:Point(x:centerX-radius, y:centerY-radius), size:Size(width:radius*2, height:radius*2)))
                    insert(entity:renderedAsteroid, at:.front)
                    safe = true
                }
            }
        }
    }
    func placeShipsFront() {
        insert(entity:ship1, at:.front)
        insert(entity:ship2, at:.front)
    }
    //checks to see if the ship is running into an asteroid, direction 0 is forward, direction 1 is backward
    func checkBoundaries(player:Int) -> Bool {
        var safe = true
        var shipCenter : Point
        switch (player) {
        case 1:
            shipCenter = Point(x:ship1X, y:ship1Y)
        default:
            shipCenter = Point(x:ship2X, y:ship2Y)
        }
        //create a bounding rect around the ship
        let shipRadius = 32
        let shipBoundingRect = Rect(topLeft:Point(x:shipCenter.x - shipRadius, y:shipCenter.y - shipRadius), size:Size(width:shipRadius * 2, height:shipRadius * 2))
        for index in 0 ..< asteroid.count {
            let asteroidRect = asteroidRects[index]
            let asteroidContainment = asteroidRect.containment(target:shipBoundingRect)
            //the ship is not safe if touching or in the asteroid
            if ((!asteroidContainment.intersection([.overlapsLeft, .overlapsRight]).isEmpty && !asteroidContainment.intersection([.overlapsTop, .overlapsBottom]).isEmpty) || !asteroidContainment.intersection([.containedFully]).isEmpty) {
                safe = false
            }
        }
        return safe
    }
    //update the ship1X and ship1Y values
    func moveShip1(moveX:Double, moveY:Double) {
        let proposedX = Int(moveX * cos(ship1Rotate * Double.pi / 180.0))
        let proposedY = Int(moveY * sin(ship1Rotate * Double.pi / 180.0))
        ship1X += proposedX
        ship1Y -= proposedY
        let safety = checkBoundaries(player:1)
        //if not safe to move there, go back
        if (!safety) {
            ship1X -= proposedX
            ship1Y += proposedY
        }
    }
    //update the ship2X and ship2Y values
    func moveShip2(moveX:Double, moveY:Double) {
        //only proceed forwards if safe to do so
        let proposedX = Int(moveX * cos(ship2Rotate * Double.pi / 180.0))
        let proposedY = Int(moveY * sin(ship2Rotate * Double.pi / 180.0))
        ship2X += proposedX
        ship2Y -= proposedY
        let safety = checkBoundaries(player:2)
        //if not safe to move there, go back
        if (!safety) {
            ship2X -= proposedX
            ship2Y += proposedY
        }
    }
    func onMouseMove(globalLocation:Point, movement:Point) {
        let xDif = globalLocation.x - ship2X
        let yDif = -(globalLocation.y - ship2Y)
        //find the correct angle to turn ship to
        var turnAngle = atan((Double(yDif) / Double(xDif))) * (180.0 / Double.pi)
        if (xDif < 0) {
            turnAngle += 180.0
        }
        else if (xDif > 0) {
            turnAngle += 360.0
        }
        else {
            turnAngle = (yDif < 0) ? (turnAngle + 360.0) : turnAngle
        }
        if (turnAngle >= 360.0) {
            turnAngle -= 360.0
        }
        ship2Rotate = turnAngle
        //move the ship to mouse position if far enough from center of ship
        if ((xDif > 20 || xDif < -20) || (yDif > 20 || yDif < -20)) {
            moveShip2(moveX:moveAmount, moveY:moveAmount)
        }
        //update ship positions
        updateShipPositions()
    }
    func onMouseDown(globalLocation:Point) {
        let projectile = Projectile(x:ship2X + Int(40.0 * cos(ship2Rotate * Double.pi / 180.0)), y:ship2Y - Int(40.0 * sin(ship2Rotate * Double.pi / 180.0)), degree:ship2Rotate, fireVelocity:ship2FireVelocity, shipColor:ship2Color, ship1X:&ship1X, ship2X:&ship2X, ship1Y:&ship1Y, ship2Y:&ship2Y, p1Lives:&ship1Lives, p2Lives:&ship2Lives, rects:asteroidRects)
        insert(entity:projectile, at:.front)
        projectiles.append(projectile)
        insert(entity:winnerScreen, at:.front)
    }
    func onKeyDown(key:String, code:String, ctrlKey:Bool, shiftKey:Bool, altKey:Bool, metaKey:Bool) {
        switch(key) {
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
            let projectile = Projectile(x:(ship1X + Int(40.0 * cos(ship1Rotate * Double.pi / 180.0))), y:(ship1Y - Int(40.0 * sin(ship1Rotate * Double.pi / 180.0))), degree:ship1Rotate, fireVelocity:ship1FireVelocity, shipColor:ship1Color, ship1X:&ship1X, ship2X:&ship2X, ship1Y:&ship1Y, ship2Y:&ship2Y, p1Lives:&ship1Lives, p2Lives:&ship2Lives, rects:asteroidRects)
            projectiles.append(projectile)
            insert(entity:projectile, at:.front)    
            insert(entity:winnerScreen, at:.front)
        case "Enter" :
            if (!hasEntered) {
                insert(entity:Instructions, at:.front)
                hasEntered = true
            }
        case "e" :
            if (!hasInstructions && hasEntered) {
                insert(entity:player1, at:.front)
                placeShipsFront()
                ship1X = 60
                ship2X = canvasSize.width - 90
                ship1Y = (canvasSize.height / 2)
                ship2Y = (canvasSize.height / 2)
                hasInstructions = true
            }
        case "o" :
            if (!colored1 && hasInstructions)  {
                ship1Color = Color(red:124,green:185,blue:232)
                blue = true
                colored1 = true
                insert(entity:player2, at:.front)
                placeShipsFront()
            }
        case "u" :
            if (!colored1 && hasInstructions) {
                ship1Color = Color(.green)
                green = true
                colored1 = true
                insert(entity:player2, at:.front)
                placeShipsFront()
            }
        case "t" :
            if (!colored1 && hasInstructions) {
                ship1Color = Color(.red)
                red = true
                colored1 = true
                insert(entity:player2, at:.front)
                placeShipsFront()
            }
        case "v" :
            if (!colored1 && hasInstructions) { 
                ship1Color = Color(.yellow)
                yellow = true
                colored1 = true
                insert(entity:player2, at:.front)
                placeShipsFront()
            }
        case "l" :
            if (blue == false && colored1 && !hasColored && !hasRendered) {
                ship2Color = Color(red:124,green:185,blue:232)
                insert(entity:backgroundChoice, at:.front)
                warning.terminate = true
                hasColor(Colored:true) 
            } else if (!colored1) {
                //don't allow the user to continue without selecting a player 1 color
            } else {
                if hasColored == false {
                    insert(entity:warning, at:.front)
                }
            }
        case "g" :
            if (green == false && colored1 && !hasColored && !hasRendered) {
                ship2Color = Color(.green)
                insert(entity:backgroundChoice, at:.front)
                warning.terminate = true
                hasColor(Colored:true) 
            } else if (!colored1) {
                //don't allow the user to continue without selecting a player 1 color
            } else {
                if hasColored == false {
                    insert(entity:warning, at:.front)
                }
            }
            
        case "h" :
            if (red == false && colored1 && !hasColored && !hasRendered) {
                ship2Color = Color(.red)
                insert(entity:backgroundChoice, at:.front)
                warning.terminate = true
                hasColor(Colored:true) 
            } else if (!colored1) {
                //don't allow the user to continue without selecting a player 1 color
            } else {
                if hasColored == false {
                    insert(entity:warning, at:.front)
                }
            }
            
        case "k" :
            if (yellow == false && colored1 && !hasColored && !hasRendered) {
                ship2Color = Color(.yellow)
                insert(entity:backgroundChoice, at:.front)
                warning.terminate = true
                hasColor(Colored:true) 
            } else if (!colored1) {
                //don't allow the user to continue without selecting a player 1 color
            } else {
                if hasColored == false {
                    insert(entity:warning, at:.front)
                }
            }
        case "n" :
            if (hasRendered == false && hasColored) {
                insert(entity:neptuneBackground, at:.front)
                timeAmount = "2:00"
                insert(entity:statusBar, at:.front)
                placeShipsFront()
                importAsteroids()
                hasRendered = true
            }
        case "m" :
            if (hasRendered == false && hasColored) {
                insert(entity:mercuryBackground, at:.front)
                timeAmount = "1:30"
                insert(entity:statusBar, at:.front)
                placeShipsFront()
                importAsteroids()
                hasRendered = true
            }
        case "f" :
            if (hasRendered == false && hasColored) {
                insert(entity:saturnBackground, at:.front)
                timeAmount = "5:00"
                insert(entity:statusBar, at:.front)
                placeShipsFront()
                importAsteroids()
                hasRendered = true
            }
        case "y" :
            if (hasRendered == false && hasColored) {
                insert(entity:starBackground, at:.front)
                starBackground.begin()
                timeAmount = "1:00"
                insert(entity:statusBar, at:.front)
                placeShipsFront()
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
        statusBar = StatusBar(timer:&timeAmount, endVar:&gameEnded, winVar:&gameWin, p1Life:&ship1Lives, p2Life:&ship2Lives, p1Color:&ship1Color, p2Color:&ship2Color)
        ship1 = Ships(PointX:0,PointY:0,rotation:0.0,color:Color(.blue),blHoleStr:&blackHoleStrength)
        ship2 = Ships(PointX:0,PointY:0,rotation:0.0,color:Color(.green),blHoleStr:&blackHoleStrength)
        winnerScreen = WinnerScreen(endVar:&gameEnded, winVar:&gameWin, p1Color:&ship1Color, p2Color:&ship2Color)
        starBackground = StarBackground(waitStar:120,changeStar:120,waitRedGiant:120,changeRedGiant:120,waitSupernova:80,enlargeBlackHole:120,starTargetMultiplier:1.6,redGiantTargetMultiplier:3.0,blackHoleTargetMultiplier:10.0,blHoleStr:&blackHoleStrength)

        super.init(name:"Interaction")
    }
    
    //self destruct on restart
    deinit {
        
    }
    
    override func preSetup(canvasSize:Size, canvas:Canvas) {
        //move ships to starting positions
        ship1X = 60
        ship2X = canvasSize.width - 90
        ship1Y = (canvasSize.height / 2)
        ship2Y = (canvasSize.height / 2)
        updateShipPositions()
        self.canvasSize = canvasSize
        insert(entity:startingScreen, at:.back)
        insert(entity:winnerScreen, at:.front)    
        dispatcher.registerKeyDownHandler(handler: self)
        dispatcher.registerMouseMoveHandler(handler: self)
        dispatcher.registerMouseDownHandler(handler:self)
    }
    
    override func postTeardown() {
        dispatcher.unregisterKeyDownHandler(handler: self)
        dispatcher.unregisterMouseMoveHandler(handler: self)
        dispatcher.unregisterMouseDownHandler(handler:self)
    }
    
}
