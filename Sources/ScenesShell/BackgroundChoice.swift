import Scenes
import Igis
import Foundation

class ChooseMap : RenderableEntity {
    let background : Image
    var warning = Warning()
    
    init() {
        // Using a meaningful name can be helpful for debugging
        guard let backgroundURL = URL(string:"https://walrus-assets.s3.amazonaws.com/img/Space-735x490-1.jpg") else {
            fatalError("failed to load backgroundURL")
        }
        background = Image(sourceURL:backgroundURL)
        super.init(name:"ChooseMap")
    }
    
    override func setup(canvasSize:Size,canvas:Canvas) {
        canvas.setup(background)
        warning.terminate = true
        
    }
    
    override func render(canvas:Canvas) {
        let canvasSize = canvas.canvasSize!
        
        if background.isReady {
            background.renderMode = .destinationRect(Rect(topLeft:Point(x:0, y:0), size:Size(width:canvasSize.center.x*2, height:canvasSize.center.y*2)))
            canvas.render(background)
        }
        let fillStyle = FillStyle(color:Color(.deepskyblue))
        let words = Text(location:Point(x:canvasSize.center.x-450,y:100), text:"Choose Your Setting")
        words.font = "80pt Megrim"
        canvas.render(fillStyle, words)

        let words1 = Text(location:Point(x:canvasSize.center.x-620,y:200), text:"Each setting has unique features which affect the gameplay.")
        words1.font = "40pt Josefin Sans"
        canvas.render(words1)

        let words2 = Text(location:Point(x:canvasSize.center.x-470, y:300), text:"Saturn: Ships fight near the planet for 5 minutes (Press F).")
        words2.font = "30pt Josefin Sans"
        canvas.render(words2)

        let words3 = Text(location:Point(x:canvasSize.center.x-400, y:400), text:"Neptune: Ships freeze after 2 minutes (Press N).")
        words3.font = "30pt Josefin Sans"
        canvas.render(words3)

        let words4 = Text(location:Point(x:canvasSize.center.x-550, y:500), text:"Mercury: Ships melt after 1 minute and 30 seconds (Press M).")
        words4.font = "30pt Josefin Sans"
        canvas.render(words4)

        let words5 = Text(location:Point(x:canvasSize.center.x-700, y:600), text:"Star: Players must defeat each other before the star turns into a black hole (Press Y).")
        words5.font = "30pt Callout"
        canvas.render(words5)
    }
}
