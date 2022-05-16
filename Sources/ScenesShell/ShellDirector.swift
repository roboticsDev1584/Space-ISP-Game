import Igis
import Scenes

//Transition between scenes and initialize MainScene to begin the game
class ShellDirector : Director {
    required init() {
        super.init()
        enqueueScene(scene:MainScene())
    }

    override func framesPerSecond() -> Int {
        return 30
    }

}

