import Foundation
import Igis
import Scenes

class StarBackground : RenderableEntity {
    //set up star images
    let star : Image
    let redGiant : Image
    let supernova : Image
    let blackHole : Image
    let stars : Image

    //initialize image scaling
    let starHeightPercent = 50.0
    let starWidthPercent = 90.0
    let redGiantHeightPercent = 80.0
    let redGiantWidthPercent = 80.0
    let supernovaHeightPercent = 64.0
    let supernovaWidthPercent = 86.0
    let blackHoleHeightPercent = 56.0
    let blackHoleWidthPercent = 56.0

    //set up image change timing
    let waitStar : Int
    let changeStar : Int
    let waitRedGiant : Int
    let changeRedGiant : Int
    let waitSupernova : Int
    let enlargeBlackHole : Int
    let starTargetMultiplier : Double
    let redGiantTargetMultiplier : Double
    let blackHoleTargetMultiplier : Double

    //get canvas size
    var canvasSizeC : Size

    //keep track of the current time when changing maps
    var timeCount : Int

    // used to tell the user the current state of the background
    var state : Int
    
    //used to resize the backgrounds in render()
    var currentScale : Double

    //set up black hole strength pointer to set current black hole strength
    var blHoleStrength = 0
    var blackHoleStrengthPointer : UnsafeMutablePointer<Int>
    
    //render star images
    func renderPlanet(canvasSz:Size, canvas:Canvas, planet:Image, planetHeight:Double, planetWidth:Double, multiplier:Double, backgroundShow:Bool = true) {
        //only render black background behind image if backgroundShow is set to true
        if (backgroundShow) {
            let backgroundRect = Rect(size:canvasSz)
            let background = Rectangle(rect:backgroundRect, fillMode:.fillAndStroke)
            let backgroundFill = FillStyle(color:Color(.black))
            canvas.render(backgroundFill, background)
        }

        //variable used to denote the smallest canvasSize dimension
        let canvasSzRef = (canvasSz.width < canvasSz.height) ? canvasSz.width : canvasSz.height

        //scale the star images and render when ready
        let scaledWidth = (planetWidth / 100.0) * Double(canvasSzRef)
        let scaledHeight = (planetHeight / 100.0) * Double(canvasSzRef)
        let planetRect = Rect(topLeft:Point(x:Int((Double(canvasSz.width) / 2.0) - (scaledWidth * multiplier / 2.0)),y:Int((Double(canvasSz.height) / 2.0) - (scaledHeight * multiplier / 2.0))), size:Size(width:Int(scaledWidth * multiplier), height:Int(scaledHeight * multiplier)))
        if planet.isReady {
            planet.renderMode = .destinationRect(planetRect)
            canvas.render(planet)
        }
    }
    
    //this function starts the background animation
    func begin() {
        state = 0
        timeCount = 0
    }
    
    //this function tells the higher-level code if the background is currently a star (0), red giant (1), etc.
    func getState() -> Int {
        return state
    }
    
    init(waitStar:Int, changeStar:Int, waitRedGiant:Int, changeRedGiant:Int, waitSupernova:Int, enlargeBlackHole:Int, starTargetMultiplier:Double, redGiantTargetMultiplier:Double, blackHoleTargetMultiplier:Double, blHoleStr:inout Int) {
        //initialize variables
        canvasSizeC = Size(width:0, height:0)
        timeCount = 0
        state = -1
        currentScale = 1.0
        blackHoleStrengthPointer = .init(&blHoleStr)

        //initialize constants
        self.waitStar = waitStar
        self.changeStar = changeStar
        self.waitRedGiant = waitRedGiant
        self.changeRedGiant = changeRedGiant
        self.waitSupernova = waitSupernova
        self.enlargeBlackHole = enlargeBlackHole
        self.starTargetMultiplier = starTargetMultiplier
        self.redGiantTargetMultiplier = redGiantTargetMultiplier
        self.blackHoleTargetMultiplier = blackHoleTargetMultiplier

        //form the image urls
        guard let starURL = URL(string:"https://images.pond5.com/star-surface-solar-flares-burning-footage-087974483_iconl.jpeg") else {
            fatalError("Failed to create URL")
        }
        guard let redGiantURL = URL(string:"https://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/Gacrux.png/600px-Gacrux.png") else {
            fatalError("Failed to create URL")
        }
        guard let supernovaURL = URL(string:"https://upload.wikimedia.org/wikipedia/commons/c/ca/Supernova_%28CGI%29.jpg") else {
            fatalError("Failed to create URL")
        }
        guard let blackHoleURL = URL(string:"https://roboticsdev1584.github.io/Save-San-Francisco/Content/BlackHole.jpg") else {
            fatalError("Failed to create URL")
        }
        guard let starsURL = URL(string:"https://roboticsdev1584.github.io/Save-San-Francisco/Content/Stars.png") else {
            fatalError("Failed to create URL")
        }
        
        //form the image objects
        star = Image(sourceURL:starURL)
        redGiant = Image(sourceURL:redGiantURL)
        supernova = Image(sourceURL:supernovaURL)
        blackHole = Image(sourceURL:blackHoleURL)
        stars = Image(sourceURL:starsURL)

        super.init(name:"StarBackground")
    }
    override func setup(canvasSize:Size, canvas:Canvas) {
        //prepare the images
        canvas.setup(star)
        canvas.setup(redGiant)
        canvas.setup(supernova)
        canvas.setup(blackHole)
        canvas.setup(stars)
        
        canvasSizeC = canvasSize
    }
    override func render(canvas:Canvas) {
        //this keeps the background time up-to-date
        timeCount = timeCount + 1

        //this switches the background when each time range expires
        switch(state) {
        case 0: //waiting on the star background
            if (timeCount > waitStar) {
                timeCount = 0
                state = state + 1
            }
            renderPlanet(canvasSz:canvasSizeC, canvas:canvas, planet:star, planetHeight:starHeightPercent, planetWidth:starWidthPercent, multiplier:1.0)
        case 1: //enlarging the star background
            currentScale = starTargetMultiplier
            if (timeCount < changeStar) { //this increments the scaled size of the star over the time range
                currentScale = 1.0 + ((Double(timeCount) / Double(changeStar)) * (starTargetMultiplier - 1.0))
            }
            else if (timeCount > changeStar) {
                timeCount = 0
                state = state + 1
            }
            currentScale = (currentScale > starTargetMultiplier) ? starTargetMultiplier : currentScale //this ensures that the background is not over-scaled
            renderPlanet(canvasSz:canvasSizeC, canvas:canvas, planet:star, planetHeight:starHeightPercent, planetWidth:starWidthPercent, multiplier:currentScale)
        case 2: //waiting on the red giant background
            if (timeCount > waitRedGiant) {
                timeCount = 0
                state = state + 1
            }
            renderPlanet(canvasSz:canvasSizeC, canvas:canvas, planet:redGiant, planetHeight:redGiantHeightPercent, planetWidth:redGiantWidthPercent, multiplier:1.0)
        case 3: //enlarging the red giant background
            currentScale = redGiantTargetMultiplier
            if (timeCount < changeRedGiant) { //this increments the scaled size of the red giant over the time range
                currentScale = 1.0 + ((Double(timeCount) / Double(changeRedGiant)) * (redGiantTargetMultiplier - 1.0))
            }
            else if (timeCount > changeRedGiant) {
                timeCount = 0
                state = state + 1
            }
            currentScale = (currentScale > redGiantTargetMultiplier) ? redGiantTargetMultiplier : currentScale //this ensures that the background is not over-scaled
            renderPlanet(canvasSz:canvasSizeC, canvas:canvas, planet:redGiant, planetHeight:redGiantHeightPercent, planetWidth:redGiantWidthPercent, multiplier:currentScale)
        case 4: //waiting on the supernova background
            if (timeCount > waitSupernova) {
                timeCount = 0
                state = state + 1
                currentScale = 1.0 //this sets up the scaling for the black hole background
            }
            renderPlanet(canvasSz:canvasSizeC, canvas:canvas, planet:supernova, planetHeight:supernovaHeightPercent, planetWidth:supernovaWidthPercent, multiplier:1.8)
        case 5: //continually enlarge the black hole background
            //place the stars behind the black hole
            if stars.isReady {
                stars.renderMode = .destinationRect(Rect(topLeft:Point(x:0, y:0), size:Size(width:canvasSizeC.center.x*2, height:canvasSizeC.center.y*2)))
                canvas.render(stars)
            }
            //enlarge the black hole
            var transitionScale = currentScale
            if (timeCount < enlargeBlackHole) {
                transitionScale = transitionScale + ((Double(timeCount) / Double(enlargeBlackHole)) * 1.0)
            }
            else if (timeCount >= enlargeBlackHole) {
                timeCount = 0
                transitionScale = transitionScale + 1.0
                currentScale = currentScale + 1.0
                blHoleStrength += 1
            }
            currentScale = (currentScale > blackHoleTargetMultiplier) ? blackHoleTargetMultiplier : currentScale //this ensures that the overall background is not over-scaled
            transitionScale = (transitionScale > blackHoleTargetMultiplier) ? blackHoleTargetMultiplier : transitionScale //this ensures that the transitioning background is not over-scaled
            renderPlanet(canvasSz:canvasSizeC, canvas:canvas, planet:blackHole, planetHeight:blackHoleHeightPercent, planetWidth:blackHoleWidthPercent, multiplier:transitionScale, backgroundShow:false)
        default:
            break
        }
        //set the current black hole strength using a pointer
        blackHoleStrengthPointer.pointee = blHoleStrength
    }
}
