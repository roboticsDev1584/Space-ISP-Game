import Scenes
import Igis
import Foundation
  /*
     This class is responsible for rendering the background.
   */


class StatusBar : RenderableEntity {
//    var fillStyle : FillStyle
//    let canvas : Canvas
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"StatusBar")
    }
    
    override func setup(canvasSize:Size,canvas:Canvas) {
    }
    override func render(canvas:Canvas) {
        let canvasSize = canvas.canvasSize!

        let fillStyle = FillStyle(color:Color(.white))
        let words = Text(location:Point(x:25,y:50), text:"Lives:x")
        words.font = "30pt Callout"
        canvas.render(fillStyle, words)

        let words1 = Text(location:Point(x:canvasSize.center.x+800,y:50), text:"Lives:x")
        words1.font = "30pt Callout"
        canvas.render(words1)
        }
}
