import Scenes
import Igis
import Foundation
  /*
     This class is responsible for rendering the background.
   */


class instructions : RenderableEntity {
//    var fillStyle : FillStyle
//    let canvas : Canvas
    init() {
        // Using a meaningful name can be helpful for debugging
        super.init(name:"instructions")
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
        let words = Text(location:Point(x:canvasSize.center.x-300,y:100), text:"How to play")
        words.font = "80pt Callout"
        canvas.render(fillStyle, words)

        let words1 = Text(location:Point(x:650,y:200), text:"Each player has 3 lives")
        words1.font = "40pt Callout"
        canvas.render(words1)

        let words2 = Text(location:Point(x:200, y:300), text:"Once hit with the other player's projectile or with an asteroid the player loses a life")
        words2.font = "35pt Callout"
        canvas.render(words2)

        let words3 = Text(location:Point(x:10, y:400), text:"Player 1 use w to move forward, s to move backwards, a to rotate left, d to rotate right, and r to fire")
        words3.font = "30pt Callout"
        canvas.render(words3)

        let words4 = Text(location:Point(x:10, y:500), text:"Player 2 use 8 to move forward, 5 to move backward, 4 to rotate left, 6 to rotate right, and 7 to fire")
        words4.font = "30pt Callout"
        canvas.render(words4)

        let words5 = Text(location:Point(x:canvasSize.center.x-200, y:600), text:"Press e to continue")
        words5.font = "40pt Callout"
        canvas.render(words5)
    }
}