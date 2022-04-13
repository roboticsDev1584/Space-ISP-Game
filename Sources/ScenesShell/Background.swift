import Foundation
import Scenes
import Igis

class Background : RenderableEntity {

    let neptune : Image
    let saturn : Image
    let mercury : Image

<<<<<<< HEAD
class Background : RenderableEntity {
    init() {
        // Using a meaningful name can be helpful for debugging

        super.init(name:"Background")
        
    }

=======
    let neptuneHeightPercent = 80.0
    let neptuneWidthPercent = 80.0
    let saturnHeightPercent = 60.0
    let saturnWidthPercent = 96.0
    let mercuryHeightPercent = 80.0
    let mercuryWidthPercent = 80.0

    var canvasSizeC : Size
    
    //map rendering functions
    func renderPlanet(canvasSz:Size, canvas:Canvas, planet:Image, planetHeight:Double, planetWidth:Double) {
        let backgroundRect = Rect(size:canvasSz)
        let background = Rectangle(rect:backgroundRect, fillMode:.fillAndStroke)
        let backgroundFill = FillStyle(color:Color(.black))
        canvas.render(backgroundFill, background)

        let scaledWidth = (planetWidth / 100.0) * Double(canvasSz.width)
        let scaledHeight = (planetHeight / 100.0) * Double(canvasSz.height)
        let planetRect = Rect(topLeft:Point(x:Int((Double(canvasSz.width) / 2.0) - (scaledWidth / 2.0)),y:Int((Double(canvasSz.height) / 2.0) - (scaledHeight / 2.0))), size:Size(width:Int(scaledWidth), height:Int(scaledHeight)))
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
        guard let saturnURL = URL(string:"https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Saturn_during_Equinox.jpg/800px-Saturn_during_Equinox.jpg") else {
            fatalError("Failed to create neptune URL")
        }
        guard let mercuryURL = URL(string:"https://upload.wikimedia.org/wikipedia/commons/thumb/6/64/Mercury_transit_2.jpg/600px-Mercury_transit_2.jpg") else {
            fatalError("Failed to create neptune URL")
        }

        //form the image objects
        neptune = Image(sourceURL:neptuneURL)
        saturn = Image(sourceURL:saturnURL)
        mercury = Image(sourceURL:mercuryURL)

        super.init(name:"Background")
    }
    override func setup(canvasSize:Size, canvas:Canvas) {
        //load the images
        canvas.setup(neptune)
        canvas.setup(saturn)
        canvas.setup(mercury)

        canvasSizeC = canvasSize
    }
    override func render(canvas:Canvas) {
        //render neptune
        //renderPlanet(canvasSz:canvasSizeC, canvas:canvas, planet:neptune, planetHeight:neptuneHeightPercent, planetWidth:neptuneWidthPercent)
    
    //render saturn
    renderPlanet(canvasSz:canvasSizeC, canvas:canvas, planet:saturn, planetHeight:saturnHeightPercent, planetWidth:saturnWidthPercent)
    
    //render mercury
    //renderPlanet(canvasSz:canvasSizeC, canvas:canvas, planet:mercury, planetHeight:mercuryHeightPercent, planetWidth:mercuryWidthPercent)
    }
>>>>>>> ee0dc1237c40e2dbeba76fc904786d114ac5f5d9
}
