import Igis
import Scenes

class Stars : RenderableEntity {
    let ellipse = Ellipse(center:Point(x:0, y:0), radiusX:10, radiusY:10, fillMode:.fillAndStroke)
    let fillStyle = FillStyle(color:Color(.white))
    let strokeStyle = StrokeStyle(color:Color(.white))
    var velocityX : Int
    var velocityY : Int
    init() {
        self.velocityX = 0
        self.velocityY = 0
        super.init(name:"Stars")        
    }

    func changeVelocity(velocityX:Int, velocityY:Int) {
        self.velocityX = velocityX
        self.velocityY = velocityY
    }

    override func calculate(canvasSize:Size) {
        ellipse.center += Point(x: velocityX, y: velocityY)

        // if hits invisible rectangle then make another star
    }
    
    override func setup(canvasSize:Size, canvas:Canvas) {
        let xvalue = Int.random(in:0 ... canvasSize.width)
        ellipse.center = Point(x:xvalue, y:0)
    }

    override func render(canvas:Canvas) {
        canvas.render(fillStyle, strokeStyle, ellipse)
    }
}
