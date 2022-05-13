import Scenes
import Igis
import Foundation
  /*
     This class is responsible for rendering the background.
   */


class instructions : RenderableEntity {
//    var fillStyle : FillStyle
//    let canvas : Canvas
    let background : Image
    init() {
        // Using a meaningful name can be helpful for debugging
        guard let backgroundURL = URL(string:"https://images.unsplash.com/photo-1465101162946-4377e57745c3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8c3BhY2UlMjBiYWNrZ3JvdW5kfGVufDB8fDB8fA%3D%3D&w=1000&q=80") else {
            fatalError("failed to load backgroundURL")
        }
        background = Image(sourceURL:backgroundURL)
        super.init(name:"instructions")
    }
    
    override func setup(canvasSize:Size,canvas:Canvas) {
        canvas.setup(background)
    }
    override func render(canvas:Canvas) {
        let canvasSize = canvas.canvasSize!

        if background.isReady {
            background.renderMode = .destinationRect(Rect(topLeft:Point(x:0, y:0), size:Size(width:canvasSize.center.x*2, height:canvasSize.center.y*2)))
            canvas.render(background)
        }
        
        let fillStyle = FillStyle(color:Color(.ivory))
        let words = Text(location:Point(x:canvasSize.center.x-300,y:100), text:"How to play")
        words.font = "80pt megrim"
        canvas.render(fillStyle, words)

        let words1 = Text(location:Point(x:650,y:200), text:"Each player has 3 lives, and the player who loses all their lives first or has the least amount of lives after time runs out loses.")
        words1.font = "30pt megrim"
        canvas.render(words1)

        let words2 = Text(location:Point(x:200, y:300), text:"Once hit with the other player's projectile or with an asteroid the player loses a life.")
        words2.font = "30pt megrim"
        canvas.render(words2)

        let words3 = Text(location:Point(x:10, y:400), text:"Player 1 use w to move forward, s to move backwards, a to rotate left, d to rotate right, and r to fire.")
        words3.font = "30pt megrim"
        canvas.render(words3)

        let words4 = Text(location:Point(x:10, y:500), text:"Player 2 use the mouse to move around the screen and left mouse click to shoot.")
        words4.font = "30pt megrim"
    }
}
