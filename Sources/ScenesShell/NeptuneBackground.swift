import Foundation
import Igis
import Scenes

class NeptuneBackground : RenderableEntity {
    //set up planet image variables
    let neptune : Image
    let neptuneHeightPercent = 80.0
    let neptuneWidthPercent = 80.0
    var canvasSizeC : Size
    
    //render planet image
    func renderPlanet(canvasSz:Size, canvas:Canvas, planet:Image, planetHeight:Double, planetWidth:Double) {
        //set up black background behind planet
        let backgroundRect = Rect(size:canvasSz)
        let background = Rectangle(rect:backgroundRect, fillMode:.fillAndStroke)
        let backgroundFill = FillStyle(color:Color(.black))
        canvas.render(backgroundFill, background)

        //variable used to denote the smallest canvasSize dimension
        let canvasSzRef = (canvasSz.width < canvasSz.height) ? canvasSz.width : canvasSz.height

        //scale the planet image and render when ready
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
        
        //set up the image url
        guard let neptuneURL = URL(string:"https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Neptune_Full.jpg/600px-Neptune_Full.jpg") else {
            fatalError("Failed to create neptune URL")
        }
        //initialize the image object
        neptune = Image(sourceURL:neptuneURL)
        
        super.init(name:"NeptuneBackground")
    }
    override func setup(canvasSize:Size, canvas:Canvas) {
        //prepare the image
        canvas.setup(neptune)
        canvasSizeC = canvasSize
    }
    
    override func render(canvas:Canvas) {
        //render neptune
        renderPlanet(canvasSz:canvasSizeC, canvas:canvas, planet:neptune, planetHeight:neptuneHeightPercent, planetWidth:neptuneWidthPercent)
    }
}
