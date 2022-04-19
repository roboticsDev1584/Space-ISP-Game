import Foundation
import Igis
import Scenes

class Projectile : RenderableEntity {

    var projectile : Ellipse
    let projectileBody : FillStyle

    let fireVelocity : Int
    let degree : Int
    
    init(x:Int, y:Int, degree:Int, fireVelocity:Int) {        
        //initialize the projectile object
        projectile = Ellipse(center:Point(x:x,y:y), radiusX:10, radiusY:10)
        projectileBody = FillStyle(color:Color(.green))

        //initialize the projectile variables
        self.fireVelocity = fireVelocity
        self.degree = degree
        
        super.init(name:"Projectile")
    }
    
    override func render(canvas:Canvas) {
        canvas.render(projectileBody, projectile)
    }

    override func calculate(canvasSize:Size) {
        //calculate the velocity for the projectile based on rotation of ship
        let fireVelocityX = Int(Double(fireVelocity) * cos(Double(degree) * Double.pi / 180))
        let fireVelocityY = Int(Double(fireVelocity) * sin(Double(degree) * Double.pi / 180))
        
        //update the projectile position
        projectile.center += Point(x:fireVelocityX, y:fireVelocityY)
    }
}
