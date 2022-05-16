import Foundation
import Igis
import Scenes

class Projectile : RenderableEntity {
    //set up the projectile IGIS objects
    var projectile : Ellipse
    let projectileBody : FillStyle
    let projectileOutline : StrokeStyle
    let asteroidRects : [Rect]
    var asteroidRectsSides : [Int] = []

    //set up initial projectile property variables
    let fireVelocity : Double
    var fireVelocityXSign = 5
    var fireVelocityYSign = 5
    let degree : Double
    var terminate : Bool
    var lives1 = 0
    var lives2 = 0
    let radius = 6
    var inAstr = false
    var bounceCount = 0

    //set up pointers for data storage
    var ship1XPointer : UnsafeMutablePointer<Int>
    var ship2XPointer : UnsafeMutablePointer<Int>
    var ship1YPointer : UnsafeMutablePointer<Int>
    var ship2YPointer : UnsafeMutablePointer<Int>
    var lives1Pointer : UnsafeMutablePointer<Int>
    var lives2Pointer : UnsafeMutablePointer<Int>

    //set up sound effect audio
    let fireAudio : Audio
    var firstRun = true
    
    init(x:Int, y:Int, degree:Double, fireVelocity:Double, shipColor:Color, ship1X:inout Int, ship2X:inout Int, ship1Y:inout Int, ship2Y:inout Int, p1Lives:inout Int, p2Lives:inout Int, rects:[Rect]) {        
        //initialize the projectile object
        projectile = Ellipse(center:Point(x:x,y:y), radiusX:radius, radiusY:radius, fillMode:.fillAndStroke)
        projectileBody = FillStyle(color:shipColor)
        projectileOutline = StrokeStyle(color:Color(.gray))

        //initialize the projectile variables
        self.fireVelocity = fireVelocity
        self.degree = degree
        self.terminate = false
        self.asteroidRects = rects

        //set up projectile sound url
        guard let soundURL = URL(string:"https://roboticsdev1584.github.io/Save-San-Francisco/Content/ProjectileFire.mp3") else {
            fatalError("Failed to create URL for audio")
        }
        //initialize sound audio
        fireAudio = Audio(sourceURL:soundURL)

        //initialize asteroidRectsSides array
        for index2 in 0 ..< asteroidRects.count {
            asteroidRectsSides.append(0)
        }

        //initialize the pointers
        ship1XPointer = .init(&ship1X)
        ship2XPointer = .init(&ship2X)
        ship1YPointer = .init(&ship1Y)
        ship2YPointer = .init(&ship2Y)

        //get the current life data from the pointers
        lives1Pointer = .init(&p1Lives)
        lives2Pointer = .init(&p2Lives)
        self.lives1 = lives1Pointer.pointee
        self.lives2 = lives2Pointer.pointee
        
        super.init(name:"Projectile")
    }

    //if terminate is true, object is deinitialized in InteractionLayer
    deinit {
        
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        //prepare audio
        canvas.setup(fireAudio)
    }
    
    override func render(canvas:Canvas) {
        //play fire audio as soon as possible and when ready
        if (fireAudio.isReady && firstRun) {
            canvas.render(fireAudio)
            firstRun = false
        }
        
        //calculate the velocity for the projectile based on rotation of ship
        let fireVelocityX = Int(fireVelocity * cos(degree * Double.pi / 180.0))
        let fireVelocityY = -Int(fireVelocity * sin(degree * Double.pi / 180.0))
        
        //update the projectile position
        projectile.center += Point(x:(fireVelocityX * fireVelocityXSign), y:(fireVelocityY * fireVelocityYSign))
        
        //set the sensitivity for hitting the other player
        let rangeVal = 16

        //if the projectile hits player 1, player 1 loses 1 life
        if (((projectile.center.x >= (ship1XPointer.pointee - rangeVal) && projectile.center.x <= (ship1XPointer.pointee + rangeVal)) && (projectile.center.y >= (ship1YPointer.pointee - rangeVal) && projectile.center.y <= (ship1YPointer.pointee + rangeVal))) && !terminate) {
            lives1 -= 1
            terminate = true
        }

        //if the projectile hits player 2, player 2 loses 1 life
        else if (((projectile.center.x >= (ship2XPointer.pointee - rangeVal) && projectile.center.x <= (ship2XPointer.pointee + rangeVal)) && (projectile.center.y >= (ship2YPointer.pointee - rangeVal) && projectile.center.y <= (ship2YPointer.pointee + rangeVal))) && !terminate) {
            lives2 -= 1
            terminate = true
        }

        //set the current life data using pointers
        lives1Pointer.pointee = lives1
        lives2Pointer.pointee = lives2

        //use containment to know when the projectile needs to change direction
        let projectileRect = Rect(topLeft:Point(x:projectile.center.x-radius, y:projectile.center.y-radius), size:Size(width:radius*2, height:radius*2))
        let canvasSize = canvas.canvasSize!
        let canvasRect = Rect(size:canvasSize)
        let canvasContain = canvasRect.containment(target:projectileRect)

        //handle the projectile going off of the screen
        if (!canvasContain.intersection([.overlapsRight, .beyondRight]).isEmpty && fireVelocityX > 0) {
            projectile.center.x = 0
        }
        else if (!canvasContain.intersection([.overlapsLeft, .beyondLeft]).isEmpty && fireVelocityX < 0) {
            projectile.center.x = canvasSize.width
        }
        if (!canvasContain.intersection([.overlapsTop, .beyondTop]).isEmpty && fireVelocityY < 0) {
            projectile.center.y = canvasSize.height
        }
        else if (!canvasContain.intersection([.overlapsBottom, .beyondBottom]).isEmpty && fireVelocityY > 0) {
            projectile.center.y = 0
        }
        
        //handle projectile direction change
        for index in 0 ..< asteroidRects.count {
            let asteroid = asteroidRects[index]
            let astrContainment = asteroid.containment(target:projectileRect)
            let sideState = asteroidRectsSides[index]
            if (!astrContainment.intersection([.containedFully]).isEmpty) {        
                if ((sideState == 1) || (sideState == 3)) {
                    fireVelocityXSign *= -1
                    bounceCount += 1
                }
                if ((sideState == 2) || (sideState == 3)) {
                    fireVelocityYSign *= -1
                    bounceCount += 1
                }
                //the projectile was fired into the center of the asteroid
                if (sideState == 0) {
                    terminate = true
                }
            }
        }
        
        //update the asteroidRectsSides array for asteroid containment relation
        var tempAsteroidRectsSides : [Int] = []
        for index in 0 ..< asteroidRects.count {
            let asteroid = asteroidRects[index]
            let astrContainment = asteroid.containment(target:projectileRect)

            //mark the projectile's relation to the asteroid
            if (!astrContainment.intersection([.beyondFully, .overlapsFully]).isEmpty) {
                tempAsteroidRectsSides.append(3)
            }
            else if (!astrContainment.intersection([.beyondHorizontally, .overlapsHorizontally]).isEmpty) {
                tempAsteroidRectsSides.append(1)
            }
            else if (!astrContainment.intersection([.beyondVertically, .overlapsVertically]).isEmpty) {
                tempAsteroidRectsSides.append(2)
            }
            //the projectile must be fully contained in the asteroid, so use the previous value to determine what side it is coming from in this case
            else {
                tempAsteroidRectsSides.append(asteroidRectsSides[index])
            }
        }
        asteroidRectsSides = tempAsteroidRectsSides
        if (bounceCount == 3) {
            terminate = true
        }
        
        if (!terminate) {
            canvas.render(projectileBody, projectileOutline, projectile)
        }

    }

}
