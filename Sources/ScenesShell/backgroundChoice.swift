import Scenes
import Igis
import Foundation
  /*
     This class is responsible for rendering the background.
   */


class ChooseMap : RenderableEntity {
//    var fillStyle : FillStyle
//    let canvas : Canvas
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"ChooseMap")
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
        let words = Text(location:Point(x:canvasSize.center.x-330,y:100), text:"Choose your setting")
        words.font = "80pt Callout"
        canvas.render(fillStyle, words)

        let words1 = Text(location:Point(x:150,y:200), text:"Each setting has unique features which effects the gameplay")
        words1.font = "50pt Callout"
        canvas.render(words1)

        let words2 = Text(location:Point(x:canvasSize.center.x-450, y:300), text:"Saturn: INSERT SPECIAL HERE (Press s)")
        words2.font = "45pt Callout"
        canvas.render(words2)

        let words3 = Text(location:Point(x:canvasSize.center.x-470, y:400), text:"Neptune: Ships freeze after 1 minute (Press n)")
        words3.font = "45pt Callout"
        canvas.render(words3)

        let words4 = Text(location:Point(x:canvasSize.center.x-675, y:500), text:"Mercury: Ships melt after 1 minute and 30 seconds (Press m)")
        words4.font = "45pt Callout"
        canvas.render(words4)

        let words5 = Text(location:Point(x:30, y:600), text:"Star: After 30 seconds the star becomes a black hole and players must avoid getting sucked in (Press t)")
        words5.font = "34pt Callout"
        canvas.render(words5)
        }
}
