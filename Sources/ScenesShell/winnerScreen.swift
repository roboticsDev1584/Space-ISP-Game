import Scenes
import Igis
import Foundation

class WinnerScreen : RenderableEntity {
    var winText : String
    var endPointer : UnsafeMutablePointer<Bool>
    var winPointer : UnsafeMutablePointer<Int>
    
    init(endVar:inout Bool, winVar:inout Int) {
        winText = ""
        endPointer = .init(&endVar)
        winPointer = .init(&winVar)
        
        super.init(name:"WinnerScreen")
    }
    
    override func render(canvas:Canvas) {
        let canvasSize = canvas.canvasSize!
        if (endPointer.pointee) {
            //change the win screen text
            let winState = winPointer.pointee
            switch (winState) {
            case 0:
                winText = "Draw."
            default:
                winText = "Player \(winState) won!"
            }
            
            //render a solid background
            let rect = Rect(topLeft:Point(x:0, y:0), size:Size(width:canvasSize.center.x * 2, height:canvasSize.center.y * 2))
            let thing = Rectangle(rect:rect)
            let rectFillStyle = FillStyle(color:Color(.black))
            canvas.render(rectFillStyle, thing)
            //Win text
            let fillStyle = FillStyle(color:Color(.white))
            let words = Text(location:Point(x:canvasSize.center.x-250,y:canvasSize.center.y), text:winText)
            words.font = "80pt Callout"
            canvas.render(fillStyle, words)
            //Rematch text
            let words1 = Text(location:Point(x:canvasSize.center.x-190,y:canvasSize.center.y+100), text:"Rematch? Press I.")
            words1.font = "50pt Callout"
            canvas.render(words1)
        }
        else {
            canvas.render()
        }
        }
}
