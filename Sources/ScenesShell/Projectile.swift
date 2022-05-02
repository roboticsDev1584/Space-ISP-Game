import Foundation
import Igis
import Scenes

class Projectile : RenderableEntity {

    var projectile : Ellipse
    let projectileBody : FillStyle
    let projectileOutline : StrokeStyle

    let fireVelocity : Double
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
    
    init(x:Int, y:Int, degree:Double, fireVelocity:Double, shipColor:Color, ship1X:inout Int, ship2X:inout Int, ship1Y:inout Int, ship2Y:inout Int, p1Lives:inout Int, p2Lives:inout Int) {        
        //initialize the projectile object
        projectile = Ellipse(center:Point(x:x,y:y), radiusX:6, radiusY:6, fillMode:.fillAndStroke)
        projectileBody = FillStyle(color:shipColor)
        projectileOutline = StrokeStyle(color:Color(.gray))

        //initialize the projectile variables
        self.fireVelocity = fireVelocity
        self.degree = degree
        self.terminate = false

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
        projectile.center += Point(x:fireVelocityX, y:fireVelocityY)
        
        //set the sensitivity for hitting the other player
        let rangeVal = 2

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
        
        if (!terminate) {
            canvas.render(projectileBody, projectileOutline, projectile)
        }
        //stop rendering projectile if told to terminate
        else {
            canvas.render()
        }

    }

}
