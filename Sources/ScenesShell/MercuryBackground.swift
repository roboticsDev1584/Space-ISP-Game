import Foundation
import Igis
import Scenes

class MercuryBackground : RenderableEntity {
    //set up background constants
    let mercury : Image
    let mercuryHeightPercent = 80.0
    let mercuryWidthPercent = 80.0

    //set up variable for canvas size
    var canvasSizeC : Size
    
    //render the planet image
    func renderPlanet(canvasSz:Size, canvas:Canvas, planet:Image, planetHeight:Double, planetWidth:Double) {
        //set up the black background behind planet
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
        guard let mercuryURL = URL(string:"https://scx2.b-cdn.net/gfx/news/hires/2015/whatsimporta.jpg") else {
            fatalError("Failed to create neptune URL")
        }
        
        //initialize the image object
        mercury = Image(sourceURL:mercuryURL)
        
        super.init(name:"MercuryBackground")
    }
    
    override func setup(canvasSize:Size, canvas:Canvas) {
        //prepare the image
        canvas.setup(mercury)
        canvasSizeC = canvasSize
    }
    
    override func render(canvas:Canvas) {
        //render mercury
        renderPlanet(canvasSz:canvasSizeC, canvas:canvas, planet:mercury, planetHeight:mercuryHeightPercent, planetWidth:mercuryWidthPercent)
    }
}
