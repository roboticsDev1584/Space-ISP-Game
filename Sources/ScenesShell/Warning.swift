import Igis
import Scenes

class Warning: RenderableEntity {
    var warning : Text
    var terminate = false 
    init() {
        warning = Text(location:Point(x:50, y:50), text:"")
        super.init(name:"Warning")
    }

    override func render(canvas:Canvas) {
        let canvasSize = canvas.canvasSize!
        if terminate == false {
            warning = Text(location:Point(x:canvasSize.center.x-430, y:canvasSize.center.y+200), text:"Please Choose another color")
            warning.font = "50pt Ariel"
            let strokeStyle = StrokeStyle(color:Color(red:3, green:244, blue:252))
            canvas.render(strokeStyle,warning)
        } else {
            warning = Text(location:Point(x:canvasSize.center.x, y:canvasSize.center.y), text:"")
            canvas.render(warning)
        }
    }

}
