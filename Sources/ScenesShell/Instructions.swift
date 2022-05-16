import Scenes
import Igis
import Foundation

class Instructions : RenderableEntity {
    let background : Image
    init() {
        // Using a meaningful name can be helpful for debugging
        guard let backgroundURL = URL(string:"https://images.unsplash.com/photo-1520034475321-cbe63696469a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8c3BhY2UlMjBzdGFyc3xlbnwwfHwwfHw%3D&w=1000&q=80") else {
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
        let words = Text(location:Point(x:canvasSize.center.x-300,y:100), text:"How To Play")
        words.font = "80pt megrim"
        canvas.render(fillStyle, words)

        let words1 = Text(location:Point(x:canvasSize.center.x-610,y:200), text:"Each player has 3 lives; the last player standing wins otherwise it is a draw.")
        words1.font = "30pt megrim"
        canvas.render(words1)

        let words2 = Text(location:Point(x:canvasSize.center.x-350, y:300), text:"When hit by a projectile, the player loses a life.")
        words2.font = "26pt megrim"
        canvas.render(words2)

        let words3 = Text(location:Point(x:canvasSize.center.x-720, y:400), text:"Player 1 uses W to move forward, S to move backwards, A to turn left, D to turn right, and R to fire.")
        words3.font = "26pt megrim"
        canvas.render(words3)

        let words4 = Text(location:Point(x:canvasSize.center.x-600, y:500), text:"Player 2 uses the mouse to move around the screen and left mouse click to shoot.")
        words4.font = "26pt megrim"
        canvas.render(words4)

        let words5 = Text(location:Point(x:canvasSize.center.x-170, y:600), text:"Press E to continue.")
        words5.font = "26pt megrim"
        canvas.render(words5)
    }
}
