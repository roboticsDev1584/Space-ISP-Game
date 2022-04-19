import Scenes

class BackgroundLayer : Layer {

    let neptuneBackground = NeptuneBackground()
    let mercuryBackground = MercuryBackground()
    let saturnBackground = SaturnBackground()
    //conversion: 30 = 1 second
    let starBackground = StarBackground(waitStar:90,changeStar:90,waitRedGiant:90,changeRedGiant:90,waitSupernova:60,enlargeBlackHole:90,starTargetMultiplier:1.6,redGiantTargetMultiplier:3.0,blackHoleTargetMultiplier:10.0)
    let startingScreen = StartingScreen()

    var previousStarState = -1

    init() {
          // Initialize BackgroundLayer class
          super.init(name:"Background")

          // Insert background to render
          insert(entity:startingScreen, at:.back)
//          starBackground.begin()
    }
}
    
