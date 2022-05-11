import Foundation
import Igis
import Scenes

class Projectile : RenderableEntity {

    var projectile : Ellipse
    let projectileBody : FillStyle
    let projectileOutline : StrokeStyle
    let asteroidRects : [Rect]
    var asteroidRectsSides : [Int] = []
    
    let fireVelocity : Double
    var fireVelocityXSign = 1
    var fireVelocityYSign = 1
    let degree : Double
    var terminate : Bool
    var lives1 = 0
    var lives2 = 0
    let radius = 6
    var inAstr = false
    var bounceCount = 0

    var ship1XPointer : UnsafeMutablePointer<Int>
    var ship2XPointer : UnsafeMutablePointer<Int>
    var ship1YPointer : UnsafeMutablePointer<Int>
    var ship2YPointer : UnsafeMutablePointer<Int>
    var lives1Pointer : UnsafeMutablePointer<Int>
    var lives2Pointer : UnsafeMutablePointer<Int>
    
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

        //initialize asteroidRectsSides array
        for index2 in 0 ..< asteroidRects.count {
            asteroidRectsSides.append(0)
        }

        //set up the pointers
        ship1XPointer = .init(&ship1X)
        ship2XPointer = .init(&ship2X)
        ship1YPointer = .init(&ship1Y)
        ship2YPointer = .init(&ship2Y)

        //get the current life data from a pointer
        lives1Pointer = .init(&p1Lives)
        lives2Pointer = .init(&p2Lives)
        self.lives1 = lives1Pointer.pointee
        self.lives2 = lives2Pointer.pointee
        
        super.init(name:"Projectile")
    }
    
    override func render(canvas:Canvas) {
        //calculate the velocity for the projectile based on rotation of ship
        let fireVelocityX = Int(fireVelocity * cos(degree * Double.pi / 180.0))
        let fireVelocityY = -Int(fireVelocity * sin(degree * Double.pi / 180.0))
        
        //update the projectile position
        projectile.center += Point(x:(fireVelocityX * fireVelocityXSign), y:(fireVelocityY * fireVelocityYSign))
        
        //set the sensitivity for hitting the other player
        let rangeVal = 10

        if (((projectile.center.x >= (ship1XPointer.pointee - rangeVal) && projectile.center.x <= (ship1XPointer.pointee + rangeVal)) && (projectile.center.y >= (ship1YPointer.pointee - rangeVal) && projectile.center.y <= (ship1YPointer.pointee + rangeVal))) && !terminate) {
            terminate = true
            //player 1 loses one life
            lives1 -= 1
        }
        //if projectile hits player 2
        else if (((projectile.center.x >= (ship2XPointer.pointee - rangeVal) && projectile.center.x <= (ship2XPointer.pointee + rangeVal)) && (projectile.center.y >= (ship2YPointer.pointee - rangeVal) && projectile.center.y <= (ship2YPointer.pointee + rangeVal))) && !terminate) {
            terminate = true
            //player 2 loses one life
            lives2 -= 1
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
                if (sideState == 0) { //the projectile was fired into the center of the asteroid
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
            else { //the projectile must be fully contained in the asteroid, so use the previous value to determine what side it is coming from
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
        //stop rendering projectile if told to terminate
        else {
            canvas.render()
        }

    }

}
