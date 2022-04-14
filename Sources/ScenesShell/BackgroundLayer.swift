import Scenes

class BackgroundLayer : Layer {

    let neptuneBackground = NeptuneBackground()
    let mercuryBackground = MercuryBackground()
    let saturnBackground = SaturnBackground()
    let starBackground = StarBackground()

    init() {
          // Initialize BackgroundLayer class
          super.init(name:"Background")

          // Insert background to render
          insert(entity:saturnBackground, at:.back)
      }
}
    
