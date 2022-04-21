import Igis
import Scenes
import Foundation

class Ships: RenderableEntity {
    
    let lineWidth : LineWidth
    let strokeStyle : StrokeStyle
    let fillStyle : FillStyle
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
        let r = 30.0
        
        lines = Path(fillMode:.fillAndStroke)
        
        lines.moveTo(Point(x:pointX+Int(r*cos(rotation)), y:pointY+Int(r*sin(rotation))))
        lines.lineTo(Point(x:pointX+Int(r*cos(rotation+120.0)), y:pointY+Int(r*sin(rotation+120.0))))
        lines.lineTo(Point(x:pointX+Int(r*cos(rotation+240.0)), y:pointY+Int(r*sin(rotation+240.0))))
        lines.lineTo(Point(x:pointX+Int(r*cos(rotation)), y:pointY+Int(r*sin(rotation))))
        canvas.render(lineWidth, strokeStyle, fillStyle, lines)

        }

}
