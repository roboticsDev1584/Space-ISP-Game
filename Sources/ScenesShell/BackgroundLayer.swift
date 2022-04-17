import Scenes

  /*
     This class is responsible for the background Layer.
     Internally, it maintains the RenderableEntities for this layer.
   */


class BackgroundLayer : Layer {
      let Mercury1 = Mercury()
      init() {
          // Using a meaningful name can be helpful for debugging
          super.init(name:"Background")
          
          // We insert our RenderableEntities in the constructor
          
          insert(entity:Mercury1, at:.back)
      }
}
    
