import Igis
import Scenes
import Foundation

class Ships: RenderableEntity {
    
    let lineWidth : LineWidth
    let strokeStyle : StrokeStyle
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
        //recreate the ship object
        let r = 26.0
        let turretLength = 14.0
          
        fillStyle = FillStyle(color:color)
        lines = Path(fillMode:.fillAndStroke)


        if (rotation >= 0.0 && rotation <= 90.0) {
            //go to point a
            lines.moveTo(Point(x:pointX+Int((r*cos(rotation*(Double.pi / 180.0)))), y:pointY-Int((r*sin(rotation*(Double.pi / 180.0))))))
        }
        else if (rotation > 90.0 && rotation <= 180.0) {
            //go to point a
            lines.moveTo(Point(x:pointX+Int((r*cos(rotation*(Double.pi / 180.0)))), y:pointY-Int((r*sin(rotation*(Double.pi / 180.0))))))
        }
        else if (rotation > 180.0 && rotation <= 270.0) {
            //go to point a
            lines.moveTo(Point(x:pointX+Int((r*cos(rotation*(Double.pi / 180.0)))), y:pointY-Int((r*sin(rotation*(Double.pi / 180.0))))))
        }
        else if (rotation > 270.0 && rotation < 360.0) {
            //go to point a
            lines.moveTo(Point(x:pointX+Int((r*cos(rotation*(Double.pi / 180.0)))), y:pointY-Int((r*sin(rotation*(Double.pi / 180.0))))))
        }
        
        if ((rotation+120.0) > 180.0 && (rotation+120.0) <= 270.0) {
            //go to point b
            lines.lineTo(Point(x:pointX+Int((r*cos((rotation+120.0)*(Double.pi / 180.0)))), y:pointY-Int((r*sin((rotation+120.0)*(Double.pi / 180.0))))))
        }
        else if ((rotation+120.0) > 270.0 && (rotation+120.0) <= 360.0) {
            //go to point b
            lines.lineTo(Point(x:pointX+Int((r*cos((rotation+120.0)*(Double.pi / 180.0)))), y:pointY-Int((r*sin((rotation+120.0)*(Double.pi / 180.0))))))
        }
        else if ((rotation+120.0) > 360.0 && (rotation+120.0) <= 450.0) {
            //go to point b
            lines.lineTo(Point(x:pointX+Int((r*cos((rotation+120.0)*(Double.pi / 180.0)))), y:pointY-Int((r*sin((rotation+120.0)*(Double.pi / 180.0))))))
        }
        else if (((rotation+120.0) > 450.0 && (rotation+120.0) <= 480.0) || ((rotation+120.0) >= 120.0 && (rotation+120.0) <= 180.0)) {
            //go to point b
            lines.lineTo(Point(x:pointX+Int((r*cos((rotation+120.0)*(Double.pi / 180.0)))), y:pointY-Int((r*sin((rotation+120.0)*(Double.pi / 180.0))))))
        }
        if ((rotation+240.0) >= 270.0 && (rotation+240.0) < 360.0) {
            //go to point c
            lines.lineTo(Point(x:pointX+Int((r*cos((rotation+240.0)*(Double.pi / 180.0)))), y:pointY-Int((r*sin((rotation+240.0)*(Double.pi / 180.0))))))
        }
        else if ((rotation+240.0) >= 360.0 && (rotation+240.0) < 450.0) {
            //go to point c
            lines.lineTo(Point(x:pointX+Int((r*cos((rotation+240.0)*(Double.pi / 180.0)))), y:pointY-Int((r*sin((rotation+240.0)*(Double.pi / 180.0))))))
        }
        else if ((rotation+240.0) >= 450.0 && (rotation+240.0) < 540.0) {
            //go to point c
            lines.lineTo(Point(x:pointX+Int((r*cos((rotation+240.0)*(Double.pi / 180.0)))), y:pointY-Int((r*sin((rotation+240.0)*(Double.pi / 180.0))))))
        }
        else if (((rotation+240.0) >= 540.0 && (rotation+240.0) <= 600.0) || ((rotation+240.0) >= 240.0 && (rotation+240.0) < 270.0)) {
            //go to point c
            lines.lineTo(Point(x:pointX+Int((r*cos((rotation+240.0)*(Double.pi / 180.0)))), y:pointY-Int((r*sin((rotation+240.0)*(Double.pi / 180.0))))))
        }
        if (rotation >= 0.0 && rotation < 90.0) {
            //go back to point a
            lines.lineTo(Point(x:pointX+Int((r*cos(rotation*(Double.pi / 180.0)))), y:pointY-Int((r*sin(rotation*(Double.pi / 180.0))))))
        }
        else if (rotation >= 90.0 && rotation < 180.0) {
            //go back to point a
            lines.lineTo(Point(x:pointX+Int((r*cos(rotation*(Double.pi / 180.0)))), y:pointY-Int((r*sin(rotation*(Double.pi / 180.0))))))
        }
        else if (rotation >= 180.0 && rotation < 270.0) {
            //go back to point a
            lines.lineTo(Point(x:pointX+Int((r*cos(rotation*(Double.pi / 180.0)))), y:pointY-Int((r*sin(rotation*(Double.pi / 180.0))))))
        }
        else if (rotation >= 270.0 && rotation < 360.0) {
            //go back to point a
            lines.lineTo(Point(x:pointX+Int((r*cos(rotation*(Double.pi / 180.0)))), y:pointY-Int((r*sin(rotation*(Double.pi / 180.0))))))
        }

        //go to point a
        lines.moveTo(Point(x:pointX+Int((r*cos(rotation*(Double.pi / 180.0)))), y:pointY-Int((r*sin(rotation*(Double.pi / 180.0))))))
        //go to point b
        lines.lineTo(Point(x:pointX+Int((r*cos((rotation+120.0)*(Double.pi / 180.0)))), y:pointY-Int((r*sin((rotation+120.0)*(Double.pi / 180.0))))))
        //go to point c
        lines.lineTo(Point(x:pointX+Int((r*cos((rotation+240.0)*(Double.pi / 180.0)))), y:pointY-Int((r*sin((rotation+240.0)*(Double.pi / 180.0))))))
        //go back to point a
        lines.lineTo(Point(x:pointX+Int((r*cos(rotation*(Double.pi / 180.0)))), y:pointY-Int((r*sin(rotation*(Double.pi / 180.0))))))
        
        //create front turret
        lines.lineTo(Point(x:pointX+Int(((r+turretLength)*cos(rotation*(Double.pi / 180.0)))), y:pointY-Int(((r+turretLength)*sin(rotation*(Double.pi / 180.0))))))

        //create back turrets
        lines.moveTo(Point(x:pointX+Int((r*cos((rotation+120.0)*(Double.pi / 180.0)))), y:pointY-Int((r*sin((rotation+120.0)*(Double.pi / 180.0))))))
        lines.lineTo(Point(x:pointX+Int((r*cos((rotation+120.0)*(Double.pi / 180.0))))+Int(((turretLength)*cos(rotation*(Double.pi / 180.0)))), y:pointY-Int((r*sin((rotation+120.0)*(Double.pi / 180.0))))-Int(((turretLength)*sin(rotation*(Double.pi / 180.0))))))
        
        lines.moveTo(Point(x:pointX+Int((r*cos((rotation+240.0)*(Double.pi / 180.0)))), y:pointY-Int((r*sin((rotation+240.0)*(Double.pi / 180.0))))))
        lines.lineTo(Point(x:pointX+Int((r*cos((rotation+240.0)*(Double.pi / 180.0))))+Int(((turretLength)*cos(rotation*(Double.pi / 180.0)))), y:pointY-Int((r*sin((rotation+240.0)*(Double.pi / 180.0))))-Int(((turretLength)*sin(rotation*(Double.pi / 180.0))))))
        fillStyle = FillStyle(color:color)
        //update the ship

        canvas.render(lineWidth, strokeStyle, fillStyle, lines)

        }

}
