import Igis
import Scenes

class Warning: RenderableEntity {
    //set up warning text
    var warning : Text

    //initialize terminate variable to know when the warning should stop being displayed
    var terminate = false
    
    init() {
        //initialize warning text
        warning = Text(location:Point(x:50, y:50), text:"")

        super.init(name:"Warning")
    }

    override func render(canvas:Canvas) {
        //get size of canvas
        let canvasSize = canvas.canvasSize!

        //render warning text if terminate has not been set to true
        if terminate == false {
            warning = Text(location:Point(x:canvasSize.center.x-430, y:canvasSize.center.y+200), text:"Please Choose another color")
            warning.font = "50pt Ariel"
            let strokeStyle = StrokeStyle(color:Color(red:3, green:244, blue:252))
            canvas.render(strokeStyle,warning)
        } else {
            //delete the warning text if terminate is true
            warning = Text(location:Point(x:canvasSize.center.x, y:canvasSize.center.y), text:"")
            canvas.render(warning)
        }
    }

}
