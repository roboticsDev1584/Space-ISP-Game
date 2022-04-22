import Scenes
import Igis
import Foundation
  /*
     This class is responsible for rendering the background.
   */


class winnerScreen : RenderableEntity {
//    var fillStyle : FillStyle
//    let canvas : Canvas
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"winnerScreen")
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
        let words = Text(location:Point(x:canvasSize.center.x-350,y:canvasSize.center.y), text:"Player X wins!")
        words.font = "80pt Callout"
        canvas.render(fillStyle, words)

        let words1 = Text(location:Point(x:canvasSize.center.x-150,y:canvasSize.center.y+100), text:"Rematch?")
        words1.font = "50pt Callout"
        canvas.render(words1)
        }
}
