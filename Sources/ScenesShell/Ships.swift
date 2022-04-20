import Igis
import Scenes
import Foundation

class Ships: RenderableEntity {
    var lineWidth : LineWidth
    var strokeStyle : StrokeStyle
    var fillStyle : FillStyle
    var lines : Path
    
    var pointX : Int
    var pointY : Int
    var rotation : Double
    var color : Color
    
    init(PointX:Int,PointY:Int,rotation:Double,color:Color) {
        self.pointX = PointX
        self.pointY = PointY
        self.rotation = rotation
        self.color = color
        
        lineWidth = LineWidth(width:2)
        strokeStyle = StrokeStyle(color:Color(red:115, green:114, blue:114))
        fillStyle = FillStyle(color:color)
        lines = Path(fillMode:.fillAndStroke)
        
        super.init(name:"Ships")
    }
    
    
    override func render(canvas:Canvas) {
        var xvalue = pointX
        var yvalue = pointY

        let rotateX = cos(rotation * Double.pi / 180)
        xvalue += Int(rotateX)
        let rotateY = sin(rotation * Double.pi / 180)
        yvalue += Int(rotateY)

        
        lines.moveTo(Point(x:xvalue, y:yvalue))
        lines.lineTo(Point(x:xvalue, y:yvalue+20))
        lines.lineTo(Point(x:xvalue+30, y:yvalue+10))
        lines.lineTo(Point(x:xvalue, y:yvalue))
        canvas.render(lineWidth, strokeStyle, fillStyle, lines)
        }
        
}
