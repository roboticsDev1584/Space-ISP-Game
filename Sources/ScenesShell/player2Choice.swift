import Scenes
import Igis
import Foundation
  /*
     This class is responsible for rendering the background.
   */


class Player2Choose : RenderableEntity {
//    var fillStyle : FillStyle
//    let canvas : Canvas
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Player2Choose")
    }
    
    override func setup(canvasSize:Size,canvas:Canvas) {
    }
    override func render(canvas:Canvas) {
        let canvasSize = canvas.canvasSize!

        let rect = Rect(topLeft:Point(x:0, y:0), size:Size(width:canvasSize.center.x * 2, height:canvasSize.center.y * 2))
        let thing = Rectangle(rect:rect)
        let rectFillStyle = FillStyle(color:Color(.black))
        canvas.render(rectFillStyle, thing)
        
        let fillStyle = FillStyle(color:Color(.white))
        let words = Text(location:Point(x:canvasSize.center.x-400,y:50), text:"Player 2 choose your ship color")
        words.font = "80pt Callout"
        canvas.render(fillStyle, words)

        let words1 = Text(location:Point(x:canvasSize.center.x-250,y:150), text:"Red (Press r)")
        words1.font = "45pt Callout"
        canvas.render(words1)

        let words2 = Text(location:Point(x:canvasSize.center.x-250, y:250), text:"Navy (Press n)")
        words2.font = "45pt Callout"
        canvas.render(words2)

        let words3 = Text(location:Point(x:canvasSize.center.x-250, y:350), text:"Green (Press g)")
        words3.font = "45pt Callout"
        canvas.render(words3)

        let words4 = Text(location:Point(x:canvasSize.center.x-250, y:450), text:"Yellow (Press y)")
        words4.font = "45pt Callout"
        canvas.render(words4)
        }
}
