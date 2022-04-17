import Igis
import Scenes

class Ships: RenderableEntity {
    
    init() {
        super.init(name:"Ships")
    }

    func ship(color:Color,num:Int,canvas:Canvas) {
        let canvasSize = canvas.canvasSize!
        var PointX = canvasSize.center.x-num
        var PointY = canvasSize.center.y
       
        let lineWidth = LineWidth(width:2)
        let strokeStyle = StrokeStyle(color:Color(red:115, green:114, blue:114))
        let fillStyle = FillStyle(color:color)
        let lines = Path(fillMode:.fillAndStroke)
        lines.moveTo(Point(x:PointX, y:PointY))
        lines.lineTo(Point(x:PointX, y:PointY+20))
        lines.lineTo(Point(x:PointX+30, y:PointY+10))
        lines.lineTo(Point(x:PointX, y:PointY))
        canvas.render(lineWidth,strokeStyle,fillStyle,lines)
    }

    override func render(canvas:Canvas) {
        ship(color:Color(.navy),num:0,canvas:canvas)
        ship(color:Color(.green),num:40,canvas:canvas)
        ship(color:Color(.red),num:80,canvas:canvas)
        ship(color:Color(.yellow),num:-40,canvas:canvas)
    }
}
