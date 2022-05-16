import Igis
import Scenes

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

    func boundaries() -> Bool {
        var boundaries = true
        for x in 0 ..< points.count {
            let previousX = points[x].x
            let previousY = points[x].y
            if (centerX+(radius+10) >= previousX-100 && centerX-(radius+10) <= previousX+100) && (centerY+(radius+10)>=previousY-100 && centerY-(radius+10)<=previousY+100) {
                boundaries = false
            } 
        }
        return boundaries
    }
    
    override func render(canvas:Canvas) {
        if boundaries() == true {            
            canvas.render(lineWidth, strokeStyle, fillStyle, ellipse)
            
        }
    }
}
