import Foundation
import Scenes
import Igis

class Background : RenderableEntity {

    let neptune : Image

    let neptuneHeight = 400
    let neptuneWidth = 400

    var canvasSizeC : Size
    
    //map rendering functions
    func renderPlanet(canvasSz:Size, canvas:Canvas, planet:Image, planetHeight:Int, planetWidth:Int) {
        let backgroundRect = Rect(size:canvasSz)
        let background = Rectangle(rect:backgroundRect, fillMode:.fillAndStroke)
        let backgroundFill = FillStyle(color:Color(.black))
        canvas.render(backgroundFill, background)

        let planetRect = Rect(topLeft:Point(x:((canvasSz.width) / 2 - planetWidth),y:((canvasSz.height) / 2 - planetHeight)), size:Size(width:planetWidth, height:planetHeight))
        if planet.isReady {
            planet.renderMode = .destinationRect(planetRect)
            canvas.render(planet)
        }
    }
    
    init() {
        //initialize variables
        canvasSizeC = Size(width:0, height:0)
        
        //form the image urls
        guard let neptuneURL = URL(string:"https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Neptune_Full.jpg/600px-Neptune_Full.jpg") else {
            fatalError("Failed to create neptune URL")
        }

        //form the image objects
        neptune = Image(sourceURL:neptuneURL)

        super.init(name:"Background")
    }
    override func setup(canvasSize:Size, canvas:Canvas) {
        //load the images
        canvas.setup(neptune)

        canvasSizeC = canvasSize
    }
    override func render(canvas:Canvas) {
        renderPlanet(canvasSz:canvasSizeC, canvas:canvas, planet:neptune, planetHeight:neptuneHeight, planetWidth:neptuneWidth)
    }
    
}
