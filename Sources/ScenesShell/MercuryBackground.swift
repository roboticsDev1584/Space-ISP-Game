import Foundation
import Scenes
import Igis

<<<<<<< HEAD
class Mercury : RenderableEntity {
    init() {
    
=======
class MercuryBackground : RenderableEntity {

    let mercury : Image
    let mercuryHeightPercent = 80.0
    let mercuryWidthPercent = 80.0

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
        guard let mercuryURL = URL(string:"https://upload.wikimedia.org/wikipedia/commons/thumb/6/64/Mercury_transit_2.jpg/600px-Mercury_transit_2.jpg") else {
            fatalError("Failed to create neptune URL")
        }
        //form the image object
        mercury = Image(sourceURL:mercuryURL)

        super.init(name:"MercuryBackground")
    }
    override func setup(canvasSize:Size, canvas:Canvas) {
        //load the image
        canvas.setup(mercury)

        canvasSizeC = canvasSize
    }
    override func render(canvas:Canvas) {
        //render mercury
        renderPlanet(canvasSz:canvasSizeC, canvas:canvas, planet:mercury, planetHeight:mercuryHeightPercent, planetWidth:mercuryWidthPercent)
    }
>>>>>>> f91399284afb4404d4b732ea5992fd576a0a6a04
}
