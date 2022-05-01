import Foundation
import Igis
import Scenes

class Projectile : RenderableEntity {

    var projectile : Ellipse
    let projectileBody : FillStyle
    let projectileOutline : StrokeStyle

    let fireVelocity : Double
    let degree : Double
    
    init(x:Int, y:Int, degree:Double, fireVelocity:Double, shipColor:Color) {        
        //initialize the projectile object
        projectile = Ellipse(center:Point(x:x,y:y), radiusX:6, radiusY:6)
        projectileBody = FillStyle(color:shipColor)
        projectileOutline = StrokeStyle(color:Color(.gray))

        //initialize the projectile variables
        self.fireVelocity = fireVelocity
        self.degree = degree
        
        super.init(name:"Projectile")
    }
    
    override func render(canvas:Canvas) {
        canvas.render(projectileBody, projectileOutline, projectile)
    }

    override func calculate(canvasSize:Size) {
        //calculate the velocity for the projectile based on rotation of ship
        let fireVelocityX = Int(fireVelocity * cos(degree * Double.pi / 180.0))
        let fireVelocityY = -Int(fireVelocity * sin(degree * Double.pi / 180.0))
        
        //update the projectile position
        projectile.center += Point(x:fireVelocityX, y:fireVelocityY)

        
    }
}
