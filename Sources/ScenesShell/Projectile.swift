import Igis
import Scenes

class Projectile : RenderableEntity {

    var projectile : Ellipse
    let projectileBody : FillStyle

    let fireVelocityX : Int
    let fireVelocityY : Int
    
    init(x:Int, y:Int, fireVelocityX:Int, fireVelocityY:Int) {        
        //initialize the projectile object
        projectile = Ellipse(center:Point(x:x,y:y), radiusX:10, radiusY:10)
        projectileBody = FillStyle(color:Color(.green))

        //initially make sure that the projectile is not fired
        self.fireVelocityX = fireVelocityX
        self.fireVelocityY = fireVelocityY
        
        super.init(name:"Projectile")
    }
    
    override func render(canvas:Canvas) {
        canvas.render(projectileBody, projectile)
    }

    override func calculate(canvasSize:Size) {
        projectile.center += Point(x:fireVelocityX, y:fireVelocityY)
    }
}
