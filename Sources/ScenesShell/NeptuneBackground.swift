import Foundation
import Scenes
import Igis

class NeptuneBackground : RenderableEntity {

    let neptune : Image
    let neptuneHeightPercent = 80.0
    let neptuneWidthPercent = 80.0
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
    
    init(p1Life:inout Int, p2Life:inout Int) {
        //initialize variables
        canvasSizeC = Size(width:0, height:0)
        //form the image url
        guard let neptuneURL = URL(string:"https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Neptune_Full.jpg/600px-Neptune_Full.jpg") else {
            fatalError("Failed to create neptune URL")
        }
        //form the image object
        neptune = Image(sourceURL:neptuneURL)
        
        super.init(name:"NeptuneBackground")
    }
    override func setup(canvasSize:Size, canvas:Canvas) {
        //load the image
        canvas.setup(neptune)

        canvasSizeC = canvasSize
    }
    override func render(canvas:Canvas) {
        //render neptune
        renderPlanet(canvasSz:canvasSizeC, canvas:canvas, planet:neptune, planetHeight:neptuneHeightPercent, planetWidth:neptuneWidthPercent)
    }
}
