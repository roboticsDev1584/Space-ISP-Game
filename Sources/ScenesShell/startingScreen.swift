import Scenes
import Igis

  /*
     This class is responsible for rendering the background.
   */


class StartingScreen : RenderableEntity {
    var text : Text
    
//    var fillStyle : FillStyle
//    let canvas : Canvas
    init() {
        // Using a meaningful name can be helpful for debugging
        text = Text(location:Point(x:0, y:300), text:"Hello, World!")
        super.init(name:"StartingScreen")
        
    }

    override func setup(canvasSize:Size,canvas:Canvas) {
        let rect = Rect(topLeft:Point(x:0,y:0), size:Size(width:canvasSize.width,height:canvasSize.height))
        let rectangle = Rectangle(rect:rect, fillMode:.fillAndStroke)
        let strokeStyle = StrokeStyle(color:Color(.navy))
        let lineWidth = LineWidth(width:5)
        let fillStyle = FillStyle(color:Color(.blue))
        text = Text(location:Point(x:canvasSize.center.x-250, y:canvasSize.center.y-150), text:"Tank Game")
        text.font = "70pt Arial"

        canvas.render(lineWidth, strokeStyle, fillStyle, rectangle)
        canvas.render(text)
    }

}
