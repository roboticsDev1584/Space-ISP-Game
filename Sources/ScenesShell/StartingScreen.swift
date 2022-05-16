import Foundation
import Igis
import Scenes

/*
 Audio credits:
 Aggressive Computer Gaming | ENIGMA by Alex-Productions | https://www.youtube.com/channel/UCx0_M61F81Nfb-BRXE-SeVA
 Music promoted by https://www.chosic.com/free-music/all/
 Creative Commons CC BY 3.0
 https://creativecommons.org/licenses/by/3.0/
*/

class StartingScreen : RenderableEntity {
    //set up image, text, and basic variables for screen
    var text : Text
    let background : Image
    var lifeWait = 0
    var lifeChange1 = 0
    var lifeChange2 = 0

    //set up background ratio
    var ratio : Double

    //initialize game audio
    let gameAudio : Audio
    var firstRun = true
    
    init() {
        //initialize starting screen text
        text = Text(location:Point(x:0, y:300), text:"")

        //set up background image url
        guard let backgroundURL = URL(string:"https://upload.wikimedia.org/wikipedia/commons/8/88/Blender_Foundation_-_Caminandes_-_Episode_2_-_Gran_Dillama_-_The_Earth_and_the_Sun_turn_dark_while_Koro_accidentally_electrocuted_by_an_electric_fence.png") else {
            fatalError("failed to load backgroundURL")
        }
        
        //initialize background image
        background = Image(sourceURL:backgroundURL)

        //set up audio url
        guard let audioURL = URL(string:"https://roboticsdev1584.github.io/Save-San-Francisco/Content/Game_Audio.mp3") else {
            fatalError("Failed to create URL for whitehouse")
        }

        //initialize game audio
        gameAudio = Audio(sourceURL:audioURL, shouldLoop:false)

        //set text sizing ratio
        self.ratio = 0
        
        super.init(name:"StartingScreen")
    }
    
    override func setup(canvasSize:Size,canvas:Canvas) {
        //prepare background image and audio
        ratio = (80.0/Double(canvasSize.width))
        canvas.setup(background)
        canvas.setup(gameAudio)
    }
    
    override func render(canvas:Canvas) {
        //play game audio when ready
        if (gameAudio.isReady && firstRun) {
            canvas.render(gameAudio)
            firstRun = false
        }

        //get size of canvas
        let canvasSize = canvas.canvasSize!

        //render starting screen text
        let fillStyle = FillStyle(color:Color(.white))
        text = Text(location:Point(x:canvasSize.center.x-260,y:canvasSize.center.y-150), text:"Space Force")
        text.font = "80pt megrim"
        if background.isReady {
            canvas.render(background)
        }
        canvas.render(fillStyle, text)

        text = Text(location:Point(x:canvasSize.center.x-150,y:canvasSize.center.y+250), text:"Press Enter To Start")
        text.font = "30pt megrim"
        canvas.render(text)
    }
}
