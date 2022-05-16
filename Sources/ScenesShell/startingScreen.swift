import Scenes
import Igis
import Foundation

class StartingScreen : RenderableEntity {
    var text : Text
    let background : Image
    var lifeWait = 0
    var lifeChange1 = 0
    var lifeChange2 = 0

    var ratio : Double
    //initialize game audio
    let gameAudio : Audio
    
    init() {
        // Using a meaningful name can be helpful for debugging
        text = Text(location:Point(x:0, y:300), text:"Hello, World!")
        guard let backgroundURL = URL(string:"https://upload.wikimedia.org/wikipedia/commons/8/88/Blender_Foundation_-_Caminandes_-_Episode_2_-_Gran_Dillama_-_The_Earth_and_the_Sun_turn_dark_while_Koro_accidentally_electrocuted_by_an_electric_fence.png") else {
            fatalError("failed to load backgroundURL")
        }
        background = Image(sourceURL:backgroundURL)
        //set up game audio, audio credits: need to figure out why game audio breaks the pointers
        /*
         Aggressive Computer Gaming | ENIGMA by Alex-Productions | https://www.youtube.com/channel/UCx0_M61F81Nfb-BRXE-SeVA
         Music promoted by https://www.chosic.com/free-music/all/
         Creative Commons CC BY 3.0
         https://creativecommons.org/licenses/by/3.0/
         */
        guard let audioURL = URL(string:"https://roboticsdev1584.github.io/Save-San-Francisco/Content/Game_Audio.mp3") else {
            fatalError("Failed to create URL for whitehouse")
        }
        gameAudio = Audio(sourceURL:audioURL, shouldLoop:true)
        self.ratio = 0
        
        super.init(name:"StartingScreen")
    }
    
    override func setup(canvasSize:Size,canvas:Canvas) {
        //render background
        ratio = (80.0/Double(canvasSize.width))
        canvas.setup(background)
        canvas.setup(gameAudio)
    }
    override func render(canvas:Canvas) {
        //play game audio
        if gameAudio.isReady {
            canvas.render(gameAudio)
        }
        
        let canvasSize = canvas.canvasSize!
        
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
