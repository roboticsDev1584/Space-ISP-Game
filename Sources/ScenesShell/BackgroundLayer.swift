import Scenes

  /*
     This class is responsible for the background Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */


class BackgroundLayer : Layer {
      let mercuryBackground = MercuryBackground()
      let neptuneBackground = NeptuneBackground()
      let saturnBackground = SaturnBackground()
      let starBackground = StarBackground()
      
      init() {
          // Initialize BackgroundLayer class
          super.init(name:"Background")
          
          // Insert background to render
          insert(entity:saturnBackground, at:.back)
      }
}
    
