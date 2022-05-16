import Igis
import Scenes

class Asteroids: RenderableEntity {
    //set up variables for asteroid creation
    var centerX : Int
    var centerY : Int
    var radius : Int

    //set up asteroid IGIS objects
    let fillStyle : FillStyle
    let strokeStyle : StrokeStyle
    var ellipse : Ellipse
    let lineWidth : LineWidth
    var points : [Point]

    init(centerX:Int, centerY:Int, radius:Int, asteroids:[Point]) {
        //initialize asteroid variables
        self.centerX = centerX
        self.centerY = centerY
        self.radius = radius
        self.points = asteroids

        //initialize asteroid IGIS objects
        ellipse = Ellipse(center:Point(x:centerX,y:centerY), radiusX:radius, radiusY:radius, fillMode:.fillAndStroke)
        fillStyle = FillStyle(color:Color(red:105, green:99, blue:94))
        strokeStyle = StrokeStyle(color:Color(red:66, green:62, blue:59))
        lineWidth = LineWidth(width: 5)
        
        super.init(name:"Asteroids")
    }

    //return if the asteroid will cover up another asteroid to make sure that they are evenly spaced
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

    //render the asteroids
    override func render(canvas:Canvas) {
        //render asteroid only if it is safe
        if boundaries() == true {            
            canvas.render(lineWidth, strokeStyle, fillStyle, ellipse)
            
        }
    }
}
