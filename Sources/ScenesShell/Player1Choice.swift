import Foundation
import Igis
import Scenes

class Player1Choose : RenderableEntity {
    //set up background image
    let background : Image
    
    init() {
        //set up image url
        guard let backgroundURL = URL(string:"https://digitaladdictsblog.com/wp-content/uploads/2019/01/shutterstock_295846730.jpg") else {
            fatalError("failed to load backgroundURL")
        }
        //initialize background image 
        background = Image(sourceURL:backgroundURL)
        super.init(name:"Player1Choose")
    }
    
    override func setup(canvasSize:Size,canvas:Canvas) {
        //prepare background image
        canvas.setup(background)
    }
    
    override func render(canvas:Canvas) {
        //get size of canvas
        let canvasSize = canvas.canvasSize!

        //render background image when ready
        if background.isReady {
            background.renderMode = .destinationRect(Rect(topLeft:Point(x:0, y:0), size:Size(width:canvasSize.center.x*2, height:canvasSize.center.y*2)))
            canvas.render(background)
        }

        //render player 1 choose screen text
        let fill = FillStyle(color:Color(.white))
        let words = Text(location:Point(x:canvasSize.center.x-680,y:100), text:"Player 1 choose your ship color")
        words.font = "80pt Callout"
        canvas.render(fill, words)

        let fill1 = FillStyle(color:Color(.red))
        let words1 = Text(location:Point(x:canvasSize.center.x-225,y:200), text:"Red (Press T)")
        words1.font = "45pt Callout"
        canvas.render(fill1, words1)

        let fill2 = FillStyle(color:Color(.deepskyblue))
        let words2 = Text(location:Point(x:canvasSize.center.x-230, y:300), text:"Blue (Press O)")
        words2.font = "45pt Callout"
        canvas.render(fill2, words2)

        let fill3 = FillStyle(color:Color(.lime))
        let words3 = Text(location:Point(x:canvasSize.center.x-245, y:400), text:"Green (Press U)")
        words3.font = "45pt Callout"
        canvas.render(fill3, words3)

        let fill4 = FillStyle(color:Color(.yellow))
        let words4 = Text(location:Point(x:canvasSize.center.x-255, y:500), text:"Yellow (Press V)")
        words4.font = "45pt Callout"
        canvas.render(fill4, words4)
    }
}
