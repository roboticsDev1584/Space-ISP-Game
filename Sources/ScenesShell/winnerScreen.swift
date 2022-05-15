import Scenes
import Igis
import Foundation

class WinnerScreen : RenderableEntity {
    var winText : String
    var endPointer : UnsafeMutablePointer<Bool>
    var winPointer : UnsafeMutablePointer<Int>

    var p1ColorPointer : UnsafeMutablePointer<Color>
    var p2ColorPointer : UnsafeMutablePointer<Color>
    var p1LifeColor = Color(.white)
    var p2LifeColor = Color(.white)
    var textColor = Color(.white)
    
    init(endVar:inout Bool, winVar:inout Int, p1Color:inout Color, p2Color:inout Color) {
        winText = ""
        endPointer = .init(&endVar)
        winPointer = .init(&winVar)
        p1ColorPointer = .init(&p1Color)
        p2ColorPointer = .init(&p2Color)
        
        super.init(name:"WinnerScreen")
    }
    
    override func render(canvas:Canvas) {
        let canvasSize = canvas.canvasSize!
        p1LifeColor = p1ColorPointer.pointee
        p2LifeColor = p2ColorPointer.pointee
        
        if (endPointer.pointee) {
            //change the win screen text
            let winState = winPointer.pointee
            switch (winState) {
            case 1:
                winText = "Player \(winState) won!"
                textColor = p1LifeColor
            case 2:
                winText = "Player \(winState) won!"
                textColor = p2LifeColor
            default :
                winText = "Draw."
                textColor = Color(.white)
            }
            
            //render a solid background
            let rect = Rect(topLeft:Point(x:0, y:0), size:Size(width:canvasSize.center.x * 2, height:canvasSize.center.y * 2))
            let thing = Rectangle(rect:rect)
            let rectFillStyle = FillStyle(color:Color(.black))
            canvas.render(rectFillStyle, thing)
            //Win text
            let fill = FillStyle(color:textColor)
            let words = Text(location:Point(x:canvasSize.center.x-250,y:canvasSize.center.y), text:winText)
            words.font = "80pt Callout"
            canvas.render(fill, words)
            //Rematch text
            let fill1 = FillStyle(color:Color(.white))
            let words1 = Text(location:Point(x:canvasSize.center.x-190,y:canvasSize.center.y+100), text:"Rematch? Press I.")
            words1.font = "50pt Callout"
            canvas.render(fill1, words1)
        }
        else {
            canvas.render()
        }
        }
}
