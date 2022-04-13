import Scenes

  /*
     This class is responsible for the background Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */


class BackgroundLayer : Layer {
      let MercuryBackground1 = MercuryBackground()
      let NeptuneBackground1 = NeptuneBackground()
      init() {
          // Using a meaningful name can be helpful for debugging
          super.init(name:"Background")
          
          // We insert our RenderableEntities in the constructor
          insert(entity:NeptuneBackground1, at:.back)
      }
}
    
