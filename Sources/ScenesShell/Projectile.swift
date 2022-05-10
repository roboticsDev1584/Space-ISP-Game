import Foundation
import Igis
import Scenes

class Projectile : RenderableEntity {

    var projectile : Ellipse
    let projectileBody : FillStyle
    let projectileOutline : StrokeStyle
    let asteroidRects : [Rect]

    let fireVelocity : Double
    var fireVelocityXSign = 1
    var fireVelocityYSign = 1
    let degree : Double
    var terminate : Bool
    var lives1 = 0
    var lives2 = 0

    var ship1XPointer : UnsafeMutablePointer<Int>
    var ship2XPointer : UnsafeMutablePointer<Int>
    var ship1YPointer : UnsafeMutablePointer<Int>
    var ship2YPointer : UnsafeMutablePointer<Int>
    var lives1Pointer : UnsafeMutablePointer<Int>
    var lives2Pointer : UnsafeMutablePointer<Int>
    
    init(x:Int, y:Int, degree:Double, fireVelocity:Double, shipColor:Color, ship1X:inout Int, ship2X:inout Int, ship1Y:inout Int, ship2Y:inout Int, p1Lives:inout Int, p2Lives:inout Int, rects:[Rect]) {        
        //initialize the projectile object
        projectile = Ellipse(center:Point(x:x,y:y), radiusX:6, radiusY:6, fillMode:.fillAndStroke)
        projectileBody = FillStyle(color:shipColor)
        projectileOutline = StrokeStyle(color:Color(.gray))

        //initialize the projectile variables
        self.fireVelocity = fireVelocity
        self.degree = degree
        self.terminate = false
        self.asteroidRects = rects

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

        if ((projectile.center.x >= (ship1XPointer.pointee - rangeVal) && projectile.center.x <= (ship1XPointer.pointee + rangeVal)) && (projectile.center.y >= (ship1YPointer.pointee - rangeVal) && projectile.center.y <= (ship1YPointer.pointee + rangeVal))) {
            terminate = true
            //player 1 loses one life
            lives1 -= 1
        }
        //if projectile hits player 2
        else if ((projectile.center.x >= (ship2XPointer.pointee - rangeVal) && projectile.center.x <= (ship2XPointer.pointee + rangeVal)) && (projectile.center.y >= (ship2YPointer.pointee - rangeVal) && projectile.center.y <= (ship2YPointer.pointee + rangeVal))) {
            terminate = true
            //player 2 loses one life
            lives2 -= 1
        }

        //set the current life data using pointers
        lives1Pointer.pointee = lives1
        lives2Pointer.pointee = lives2

        //use containment to know when the projectile needs to change direction
        let projectileRect = Rect(topLeft:Point(x:projectile.center.x-6, y:projectile.center.y-6), size:Size(width:12, height:12))
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
            let rectangle = Rectangle(rect:asteroid, fillMode:.fillAndStroke)
            let stroke = StrokeStyle(color:Color(.white))
            canvas.render(stroke, rectangle)
            let containment = asteroid.containment(target:projectileRect)
            //change direction if going to hit an asteroid
            if ((!containment.intersection([.overlapsRight, .beyondRight]).isEmpty && (fireVelocityX > 0)) || (!containment.intersection([.overlapsLeft, .beyondLeft]).isEmpty && (fireVelocityX < 0))) {
                fireVelocityXSign *= -1
            }
            if ((!containment.intersection([.overlapsTop, .beyondTop]).isEmpty && (fireVelocityY < 0)) || (!containment.intersection([.overlapsBottom, .beyondBottom]).isEmpty && (fireVelocityY > 0))) {
                fireVelocityYSign *= -1
            }
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
