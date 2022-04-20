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
        //initialize global variables
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
        //re-render the ship path
        var xvalue = pointX
        var yvalue = pointY
        
        let rotateX = cos(rotation * Double.pi / 180)
        xvalue += Int(rotateX)
        let rotateY = sin(rotation * Double.pi / 180)
        yvalue += Int(rotateY)
        
        lines = Path(fillMode:.fillAndStroke)
        lines.moveTo(Point(x:xvalue, y:yvalue))
        lines.lineTo(Point(x:xvalue, y:yvalue+20))
        lines.lineTo(Point(x:xvalue+30, y:yvalue+10))
        lines.lineTo(Point(x:xvalue, y:yvalue))
        canvas.render(lineWidth, strokeStyle, fillStyle, lines)
    }
}
