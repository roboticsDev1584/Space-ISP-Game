import Scenes
import Igis
import Foundation
  /*
     This class is responsible for rendering the background.
   */


class StartingScreen : RenderableEntity {
    var text : Text
    let background : Image
//    var fillStyle : FillStyle
//    let canvas : Canvas
    init() {
        // Using a meaningful name can be helpful for debugging
        text = Text(location:Point(x:0, y:300), text:"Hello, World!")
        guard let backgroundURL = URL(string:"https://upload.wikimedia.org/wikipedia/commons/8/88/Blender_Foundation_-_Caminandes_-_Episode_2_-_Gran_Dillama_-_The_Earth_and_the_Sun_turn_dark_while_Koro_accidentally_electrocuted_by_an_electric_fence.png") else {
            fatalError("failed to load backgroundURL")
        }
        background = Image(sourceURL:backgroundURL)
        
        super.init(name:"StartingScreen")
    }

    override func setup(canvasSize:Size,canvas:Canvas) {
        canvas.setup(background)
    }
    override func render(canvas:Canvas) {
        let canvasSize = canvas.canvasSize!
        
        let fillStyle = FillStyle(color:Color(.white))
        text = Text(location:Point(x:canvasSize.center.x-260,y:canvasSize.center.y-150), text:"Space Force")
        text.font = "80pt callout"
        if background.isReady {
            canvas.render(background)
        }
        canvas.render(fillStyle, text)

        text = Text(location:Point(x:canvasSize.center.x-190,y:canvasSize.center.y+250), text:"Press Enter To Start")
        text.font = "30pt Ariel"
        canvas.render(text)
    }

    

}
