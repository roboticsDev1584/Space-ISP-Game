import Igis
import Scenes

class Ship : RenderableEntity {

    var ship : Rectangle
    var rect : Rect
    let shipBody : FillStyle

    var shipXPos : Int
    var shipYPos : Int

    init() {
        //initialize the ship starting position
        shipXPos = 0
        shipYPos = 0
        
        //initialize the ship object
        rect = Rect(topLeft:Point(x:0, y:0), size:Size(width:30, height:70))
        ship = Rectangle(rect:rect, fillMode:.fillAndStroke)
        shipBody = FillStyle(color:Color(.red))

        super.init(name:"Ship")
    }
    
    override func render(canvas:Canvas) {
        canvas.render(shipBody, ship)
    }

    func move(x:Int, y:Int) {
        ship.rect.topLeft = Point(x:x, y:y)
    }
}
