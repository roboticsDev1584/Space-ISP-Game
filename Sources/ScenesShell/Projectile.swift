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

    var randomInt1 = 0
    var randomInt2 = 0
    var randomInt3 = 0
    var randomInt4 = 0
    var randomInt5 = 0
    var randomInt6 = 0
    var ship1XPointer : UnsafeMutablePointer<Int>
    var ship2XPointer : UnsafeMutablePointer<Int>
    var ship1YPointer : UnsafeMutablePointer<Int>
    var ship2YPointer : UnsafeMutablePointer<Int>
    var lives1Pointer : UnsafeMutablePointer<Int>
    var lives2Pointer : UnsafeMutablePointer<Int>
    
    init(x:Int, y:Int, degree:Double, fireVelocity:Double, shipColor:Color) {        
        //initialize the projectile object
        projectile = Ellipse(center:Point(x:x,y:y), radiusX:6, radiusY:6)
        projectileBody = FillStyle(color:shipColor)
        projectileOutline = StrokeStyle(color:Color(.gray))

        //initialize the projectile variables
        self.fireVelocity = fireVelocity
        self.degree = degree
        self.terminate = false

        ship1XPointer = .init(&randomInt1)
        ship2XPointer = .init(&randomInt2)
        ship1YPointer = .init(&randomInt3)
        ship2YPointer = .init(&randomInt4)
        lives1Pointer = .init(&randomInt5)
        lives2Pointer = .init(&randomInt6)
        
        super.init(name:"Projectile")
    }

    func linkShipVariables(ship1X:inout Int, ship2X:inout Int, ship1Y:inout Int, ship2Y:inout Int, p1Lives:inout Int, p2Lives:inout Int) {
        ship1XPointer = .init(&ship1X)
        ship2XPointer = .init(&ship2X)
        ship1YPointer = .init(&ship1Y)
        ship2YPointer = .init(&ship2Y)
        lives1Pointer = .init(&p1Lives)
        lives2Pointer = .init(&p2Lives)
        lives1 = lives1Pointer.pointee
        lives2 = lives2Pointer.pointee
    }
    
    override func render(canvas:Canvas) {
        //calculate the velocity for the projectile based on rotation of ship
        let fireVelocityX = Int(fireVelocity * cos(degree * Double.pi / 180.0))
        let fireVelocityY = -Int(fireVelocity * sin(degree * Double.pi / 180.0))
        
        //update the projectile position
        projectile.center += Point(x:fireVelocityX, y:fireVelocityY)
        
        //if projectile hits player 1
        if (projectile.center.x == ship1XPointer.pointee && projectile.center.y == ship1YPointer.pointee) {
            terminate = true
            //player 1 loses one life
            self.lives1 -= 1
        }
        //if projectile hits player 2
        else if (projectile.center.x == ship2XPointer.pointee && projectile.center.y == ship2YPointer.pointee) {
            terminate = true
            //player 2 loses one life
            self.lives2 -= 1
        }
        print("lives1: " + String(self.lives1))
        print("lives2: " + String(self.lives2))

        lives1Pointer.pointee = self.lives1
        lives2Pointer.pointee = self.lives2

        if (lives1Pointer.pointee != 3) {
            print(lives1Pointer.pointee)
        }
        else if (lives2Pointer.pointee != 3) {
            print(lives2Pointer.pointee)
        }
        
        if (!terminate) {
            canvas.render(projectileBody, projectileOutline, projectile)
        }
        //stop rendering projectile if told to terminate
        else {
            canvas.render()
        }
    }

    /*override func calculate(canvasSize:Size) {
       //calculate the velocity for the projectile based on rotation of ship
        let fireVelocityX = Int(fireVelocity * cos(degree * Double.pi / 180.0))
        let fireVelocityY = -Int(fireVelocity * sin(degree * Double.pi / 180.0))
        
        //update the projectile position
        projectile.center += Point(x:fireVelocityX, y:fireVelocityY)
        
        //if projectile hits player 1
        if (projectile.center.x == ship1XPointer.pointee && projectile.center.y == ship1YPointer.pointee) {
            terminate = true
            //player 1 loses one life
            self.lives1 -= 1
        }
        //if projectile hits player 2
        else if (projectile.center.x == ship2XPointer.pointee && projectile.center.y == ship2YPointer.pointee) {
            terminate = true
            //player 2 loses one life
            self.lives2 -= 1
        }
        print("lives1: " + String(self.lives1))
        print("lives2: " + String(self.lives2))

        lives1Pointer.pointee = self.lives1
        lives2Pointer.pointee = self.lives2

        if (lives1Pointer.pointee != 3) {
            print(lives1Pointer.pointee)
        }
        else if (lives2Pointer.pointee != 3) {
            print(lives2Pointer.pointee)
        }
    }*/
}
