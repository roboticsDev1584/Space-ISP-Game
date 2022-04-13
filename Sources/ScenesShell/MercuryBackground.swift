import Scenes
import Igis
  /*
     This class is responsible for the background Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */


class MercuryBackground : RenderableEntity {
    var didDraw = false
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"MercuryBackground")
    }
    override func render(canvas:Canvas) {
        let canvasSize = canvas.canvasSize!
        let mainRect = Rect(topLeft:Point(x:0, y:0), size:canvasSize)
        let mainRectangle = Rectangle(rect:mainRect)
        let mainFillColor = FillStyle(color:Color(.black))
        canvas.render(mainFillColor, mainRectangle)
        let planetEllipse = Ellipse(center:Point(x:canvasSize.center.x, y:canvasSize.center.y), radiusX:400, radiusY:400, fillMode:.fillAndStroke)
        let planetFillColor = FillStyle(color:Color(.silver))
        let planetStrokeColor = StrokeStyle(color:Color(.black))
        let planetLineWidth = LineWidth(width:10)
        canvas.render(planetStrokeColor, planetFillColor, planetLineWidth, planetEllipse)
        var a = canvasSize.center.x - 250
        var b = canvasSize.center.y - 200
        var c = 50
        var d = 75
        let spotEllipse = Ellipse(center:Point(x:a, y:b), radiusX:c, radiusY:d, fillMode:.fillAndStroke)
        let spotFillColor = FillStyle(color:Color(.silver))
        let spotStrokeColor = StrokeStyle(color:Color(.darkgray))
        let spotLineWidth = LineWidth(width:10)
        canvas.render(spotStrokeColor, spotFillColor, spotLineWidth, spotEllipse)
        a += 200
        b += 200
        c += 25
        d += 60
        for _ in 0...1 {
            let spotEllipse = Ellipse(center:Point(x:a, y:b), radiusX:c, radiusY:d, fillMode:.fillAndStroke)
            let spotFillColor = FillStyle(color:Color(.silver))
            let spotStrokeColor = StrokeStyle(color:Color(.darkgray))
            let spotLineWidth = LineWidth(width:10)
            canvas.render(spotStrokeColor, spotFillColor, spotLineWidth, spotEllipse)
            a -= 100
            b += 200
            c -= 10
            d -= 15
        }
        let sunEllipse = Ellipse(center:Point(x:0, y:0), radiusX:300, radiusY:300, fillMode:.fillAndStroke)
        let sunFillColor = FillStyle(color:Color(.orange))
        let sunStrokeColor = StrokeStyle(color:Color(.darkorange))
        let sunLineWidth = LineWidth(width:7)
        canvas.render(sunStrokeColor, sunFillColor, sunLineWidth, sunEllipse)
    }
}

