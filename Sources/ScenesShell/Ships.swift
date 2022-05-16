import Foundation
import Igis
import Scenes

class Ships: RenderableEntity {
    //set up ship IGIS object
    let lineWidth : LineWidth
    let strokeStyle : StrokeStyle
    var fillStyle : FillStyle
    var lines : Path

    //set up ship property variables
    var pointX : Int
    var pointY : Int
    var rotation : Double
    var color : Color

    //get strength of black hole by setting up a pointer
    var blackHoleStrengthPointer : UnsafeMutablePointer<Int>
    
    init(PointX:Int,PointY:Int,rotation:Double,color:Color, blHoleStr:inout Int) {
        //initialize ship variables
        self.pointX = PointX
        self.pointY = PointY
        self.rotation = rotation
        self.color = color

        //initialize black hole strength pointer
        blackHoleStrengthPointer = .init(&blHoleStr)

        //intialize ship IGIS object
        lineWidth = LineWidth(width:2)
        strokeStyle = StrokeStyle(color:Color(red:115, green:114, blue:114))
        fillStyle = FillStyle(color:color)
        lines = Path(fillMode:.fillAndStroke)
        
        super.init(name:"Ships")
    }
    
    
    override func render(canvas:Canvas) {
        //get size of canvas
        let canvasSize = canvas.canvasSize!
        
        //get current black hole strength
        let blackHoleMove = 1
        let blStr = blackHoleStrengthPointer.pointee

        //if a black hole exists, move ship towards center based on strength
        if (blStr > 0) {
            pointX -= blackHoleMove * blStr
            pointY -= blackHoleMove * blStr
            
            //make sure that the ships are not pulled beyond the center point in a black hole
            pointX = (pointX < canvasSize.center.x) ? canvasSize.center.x : pointX
            pointY = (pointY < canvasSize.center.y) ? canvasSize.center.y : pointY
        }
        
        //set the radius and turret length of the ship
        let r = 26.0
        let turretLength = 14.0

        //initialize ship path object
        fillStyle = FillStyle(color:color)
        lines = Path(fillMode:.fillAndStroke)

        //create ship object based on rotation variable
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

        //render the ship
        canvas.render(lineWidth, strokeStyle, fillStyle, lines)

    }

}
