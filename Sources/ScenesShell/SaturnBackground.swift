import Foundation
import Scenes
import Igis

class SaturnBackground : RenderableEntity {

    let saturn : Image
    let saturnHeightPercent = 60.0
    let saturnWidthPercent = 96.0
    var canvasSizeC : Size
    
    //map rendering functions
    func renderPlanet(canvasSz:Size, canvas:Canvas, planet:Image, planetHeight:Double, planetWidth:Double) {
        let backgroundRect = Rect(size:canvasSz)
        let background = Rectangle(rect:backgroundRect, fillMode:.fillAndStroke)
        let backgroundFill = FillStyle(color:Color(.black))
        canvas.render(backgroundFill, background)

        //variable used to denote the smallest canvasSize dimension
        let canvasSzRef = (canvasSz.width < canvasSz.height) ? canvasSz.width : canvasSz.height
        
        let scaledWidth = (planetWidth / 100.0) * Double(canvasSzRef)
        let scaledHeight = (planetHeight / 100.0) * Double(canvasSzRef)
        let planetRect = Rect(topLeft:Point(x:Int((Double(canvasSz.width) / 2.0) - (scaledWidth / 2.0)),y:Int((Double(canvasSz.height) / 2.0) - (scaledHeight / 2.0))), size:Size(width:Int(scaledWidth), height:Int(scaledHeight)))
        if planet.isReady {
            planet.renderMode = .destinationRect(planetRect)
            canvas.render(planet)
        }
    }
    
    init() {
        //initialize variables
        canvasSizeC = Size(width:0, height:0)
        //form the image url
        guard let saturnURL = URL(string:"https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Saturn_during_Equinox.jpg/800px-Saturn_during_Equinox.jpg") else {
            fatalError("Failed to create neptune URL")
        }
        //form the image object
        saturn = Image(sourceURL:saturnURL)
        
        super.init(name:"SaturnBackground")
    }
    override func setup(canvasSize:Size, canvas:Canvas) {
        //load the image
        canvas.setup(saturn)

        canvasSizeC = canvasSize
    }
    override func render(canvas:Canvas) {
        //render saturn
        renderPlanet(canvasSz:canvasSizeC, canvas:canvas, planet:saturn, planetHeight:saturnHeightPercent, planetWidth:saturnWidthPercent)
    }
}
