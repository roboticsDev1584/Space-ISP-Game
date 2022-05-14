import Igis
import Scenes

class BackgroundLayer : Layer {

    //let neptuneBackground = NeptuneBackground()
    //let mercuryBackground = MercuryBackground()
    //let saturnBackground = SaturnBackground()
    //let backgroundChoice = ChooseMap()
    //conversion: 30 = 1 second
    //let starBackground = StarBackground(waitStar:90,changeStar:90,waitRedGiant:90,changeRedGiant:90,waitSupernova:60,enlargeBlackHole:90,starTargetMultiplier:1.6,redGiantTargetMultiplier:3.0,blackHoleTargetMultiplier:10.0)

    //let startingScreen = StartingScreen()
    //let player1 = Player1Choose()
    //let player2 = Player2Choose()

    init() {
          // Insert background to render
        // Using a meaningful name can be helpful for debugging
        super.init(name:"Background")
        //insert(entity:startingScreen, at:.back)         
        // We insert our RenderableEntities in the constructor
        //insert(entity:player1, at:.back)
    }
}

 
