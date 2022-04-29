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
    /*var lives1Pointer : UnsafeMutablePointer<Int>
    var lives2Pointer : UnsafeMutablePointer<Int>*/
    
    init(x:Int, y:Int, degree:Double, fireVelocity:Double, shipColor:Color, ship1X:inout Int, ship2X:inout Int, ship1Y:inout Int, ship2Y:inout Int, p1Lives:inout Int, p2Lives:inout Int) {        
        //initialize the projectile object
        projectile = Ellipse(center:Point(x:x,y:y), radiusX:6, radiusY:6)
        projectileBody = FillStyle(color:shipColor)
        projectileOutline = StrokeStyle(color:Color(.gray))

        //initialize the projectile variables
        self.fireVelocity = fireVelocity
        self.degree = degree
        self.terminate = false

        ship1XPointer = .init(&ship1X)
        ship2XPointer = .init(&ship2X)
        ship1YPointer = .init(&ship1Y)
        ship2YPointer = .init(&ship2Y)
        /*lives1Pointer = .init(&p1Lives)
        lives2Pointer = .init(&p2Lives)
        self.lives1 = lives1Pointer.pointee
        self.lives2 = lives2Pointer.pointee*/
        
        super.init(name:"Projectile")
    }
    
    override func render(canvas:Canvas) {
        //calculate the velocity for the projectile based on rotation of ship
        let fireVelocityX = Int(fireVelocity * cos(degree * Double.pi / 180.0))
        let fireVelocityY = -Int(fireVelocity * sin(degree * Double.pi / 180.0))
        
        //update the projectile position
        projectile.center += Point(x:fireVelocityX, y:fireVelocityY)
        
        //if projectile hits player 1
        //print(String(projectile.center.x))
        //print(String(ship2XPointer.pointee))
        /*print(String(projectile.center.y))
          print(String(ship2YPointer.pointee))*/

        //figured out that the pointer updates a bit slowly, so need bounds to actually detect a hit
        if (projectile.center.x >= (ship2XPointer.pointee - 5) && projectile.center.x <= (ship2XPointer.pointee + 5)) {
            print("here")
        }
        if (projectile.center.x == ship1XPointer.pointee && projectile.center.y == ship1YPointer.pointee) {
            terminate = true
            //player 1 loses one life
            lives1 -= 1
            print("hit!")
        }
        //if projectile hits player 2
        else if (projectile.center.x == ship2XPointer.pointee && projectile.center.y == ship2YPointer.pointee) {
            terminate = true
            //player 2 loses one life
            lives2 -= 1
            print("hit!")
        }
        //print("lives1: " + String(lives1))
        //print("lives2: " + String(lives2))
        
        /*lives1Pointer.pointee = lives1
        lives2Pointer.pointee = lives2

        if (lives1Pointer.pointee != 3) {
            print(lives1Pointer.pointee)
        }
        else if (lives2Pointer.pointee != 3) {
            print(lives2Pointer.pointee)
        }*/
        
        if (!terminate) {
            canvas.render(projectileBody, projectileOutline, projectile)
        }
        //stop rendering projectile if told to terminate
        else {
            canvas.render()
        }
    }

}
