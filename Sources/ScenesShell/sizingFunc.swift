import Scenes
import Igis

class sizingFunc : RenderableEntity {
    var ratio : Double
    
    init() {
        self.ratio = 0
        super.init(name:"SizingFunc")
    }

    override func setup(canvasSize:Size, canvas:Canvas) {
        ratio = (80.0/Double(canvasSize.width)) * 100.0
        print(ratio)
    }
}
