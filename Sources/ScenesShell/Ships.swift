import Igis
import Scenes
import Foundation

class Ships: RenderableEntity {
    let lineWidth : LineWidth
    let strokeStyle : StrokeStyle
    let fillStyle : FillStyle
    let lines : Path
    
    
    init(PointX:Int,PointY:Int,rotation:Double,color:Color) {
        var xvalue = PointX
        var yvalue = PointY
        lineWidth = LineWidth(width:2)
        strokeStyle = StrokeStyle(color:Color(red:115, green:114, blue:114))
        fillStyle = FillStyle(color:color)
        
        let rotateX = cos(rotation * Double.pi / 180)
        xvalue += Int(rotateX)
        let rotateY = sin(rotation * Double.pi / 180)
        yvalue += Int(rotateY)
        
        lines = Path(fillMode:.fillAndStroke)
        lines.moveTo(Point(x:xvalue, y:yvalue))
        lines.lineTo(Point(x:xvalue, y:yvalue+20))
        lines.lineTo(Point(x:xvalue+30, y:yvalue+10))
        lines.lineTo(Point(x:xvalue, y:yvalue))
        
        
        super.init(name:"Ships")
    }

/*
    override func render(canvas:Canvas) {
    canvas.render(lineWidth,strokeStyle,fillStyle,lines)
    
 */
    func ship(color:Color,num:Int,canvas:Canvas) {
        let canvasSize = canvas.canvasSize!
        let PointX = canvasSize.center.x-num
        let PointY = canvasSize.center.y
       
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

    }
}
