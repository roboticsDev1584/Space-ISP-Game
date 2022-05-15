import Scenes
import Igis
import Foundation

class StartingScreen : RenderableEntity {
    var text : Text
    let background : Image
    var lifeWait = 0
    var lifeChange1 = 0
    var lifeChange2 = 0

    //var p1LifePointer : UnsafeMutablePointer<Int>
    //var p2LifePointer : UnsafeMutablePointer<Int>

    var ratio : Double
    
    init(p1Life:inout Int, p2Life:inout Int) {
        // Using a meaningful name can be helpful for debugging
        text = Text(location:Point(x:0, y:300), text:"Hello, World!")
        guard let backgroundURL = URL(string:"https://upload.wikimedia.org/wikipedia/commons/8/88/Blender_Foundation_-_Caminandes_-_Episode_2_-_Gran_Dillama_-_The_Earth_and_the_Sun_turn_dark_while_Koro_accidentally_electrocuted_by_an_electric_fence.png") else {
            fatalError("failed to load backgroundURL")
        }
        background = Image(sourceURL:backgroundURL)
        /*p1LifePointer = .init(&p1Life)
        p2LifePointer = .init(&p2Life)*/
        self.ratio = 0
        
        super.init(name:"StartingScreen")
    }

    //function to center text based on font size that changes based on screen size (% font size)
    func centerText (fontSizePercent:Int, fontColor:Color, text:String, canvas:Canvas, canvasSize:Size) {
        
    }
    
    override func setup(canvasSize:Size,canvas:Canvas) {
        //render background
        ratio = (80.0/Double(canvasSize.width))
        canvas.setup(background)
    }
    override func render(canvas:Canvas) {
        //makes sure that the life pointers are properly set to 3 lives each at the start of each rematch
        /*lifeChange1 = p1LifePointer.pointee
        lifeChange2 = p2LifePointer.pointee
        if (lifeWait < 3) {
            lifeChange1 = 3
            lifeChange2 = 3
            lifeWait += 1
        }
        print("lifeChange2: \(lifeChange2)")
        p1LifePointer.pointee = lifeChange1
        p2LifePointer.pointee = lifeChange2*/
        
        let canvasSize = canvas.canvasSize!
        
        let fillStyle = FillStyle(color:Color(.white))
        text = Text(location:Point(x:canvasSize.center.x-260,y:canvasSize.center.y-150), text:"Space Force")
        text.font = "80pt megrim"
        if background.isReady {
            canvas.render(background)
        }
        canvas.render(fillStyle, text)

        text = Text(location:Point(x:canvasSize.center.x-190,y:canvasSize.center.y+250), text:"Press Enter To Start")
        text.font = "30pt megrim"
        canvas.render(text)
    }
}
