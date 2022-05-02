import Scenes
import Igis

class Asteroids: RenderableEntity {
    var centerX : Int
    var centerY : Int
    var radius : Int

    let fillStyle : FillStyle
    let strokeStyle : StrokeStyle
    var ellipse : Ellipse
    let lineWidth : LineWidth
    var points : [Point]
    
    init(centerX:Int, centerY:Int, radius:Int, asteroids:[Point]) {
        self.centerX = centerX
        self.centerY = centerY
        self.radius = radius
        self.points = asteroids
        
        ellipse = Ellipse(center:Point(x:centerX,y:centerY), radiusX:radius, radiusY:radius, fillMode:.fillAndStroke)
        fillStyle = FillStyle(color:Color(red:105, green:99, blue:94))
        strokeStyle = StrokeStyle(color:Color(red:66, green:62, blue:59))
        lineWidth = LineWidth(width: 5)
           
        super.init(name:"Asteroids")
    }

    func boundaries(canvas:Canvas) -> Bool {
        var boundaries = true
        for x in 0 ..< points.count {
            let previousX = points[x].x
            let previousY = points[x].y
            if centerX+120 >= previousX && centerX-120 <= previousX || centerY+120>=previousY && centerY-120<=previousY {
                boundaries = false
            } 
        }
        return boundaries
    }
    
    override func render(canvas:Canvas) {
        if boundaries(canvas:canvas) == true {            
            canvas.render(lineWidth, strokeStyle, fillStyle, ellipse)
            
        }
    }
}
