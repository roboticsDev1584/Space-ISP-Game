import Scenes
import Igis
  /*
     This class is responsible for the background Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */


class NeptuneBackground : RenderableEntity {
    var didDraw = false
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"NeptuneBackground")
    }
    override func render(canvas:Canvas) {
        let canvasSize = canvas.canvasSize!
        let mainRect = Rect(topLeft:Point(x:0, y:0), size:canvasSize)
        let mainRectangle = Rectangle(rect:mainRect)
        let mainFillColor = FillStyle(color:Color(.black))
        canvas.render(mainFillColor, mainRectangle)
        let planetEllipse = Ellipse(center:Point(x:canvasSize.center.x, y:canvasSize.center.y), radiusX:400, radiusY:400, fillMode:.fillAndStroke)
        let planetFillColor = FillStyle(color:Color(.royalblue))
        let planetStrokeColor = StrokeStyle(color:Color(.black))
        let planetLineWidth = LineWidth(width:10)
        canvas.render(planetStrokeColor, planetFillColor, planetLineWidth, planetEllipse)
        let sunEllipse = Ellipse(center:Point(x:0, y:0), radiusX:50, radiusY:50, fillMode:.fillAndStroke)
        let sunFillColor = FillStyle(color:Color(.orange))
        let sunStrokeColor = StrokeStyle(color:Color(.darkorange))
        let sunLineWidth = LineWidth(width:7)
        canvas.render(sunStrokeColor, sunFillColor, sunLineWidth, sunEllipse)
    }
}

