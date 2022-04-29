import Scenes
import Igis
import Foundation

class StatusBar : RenderableEntity {
    static var player1Life = 3
    static var player2Life = 3
    var time = "0:00"
    
    var count = 0
    var end = false
    var win = 0

    //var randomInt1 = 0
    //var randomInt2 = 0
    var endPointer : UnsafeMutablePointer<Bool>
    var winPointer : UnsafeMutablePointer<Int>
    var timePointer : UnsafeMutablePointer<String>
    //var exP1LifePointer : UnsafeMutablePointer<Int>
    //var exP2LifePointer : UnsafeMutablePointer<Int>
    //var localP1LifePointer : UnsafeMutablePointer<Int> 
    //var localP2LifePointer : UnsafeMutablePointer<Int>

    //need some way to indicate to InteractionLayer.swift that the game has ended
    init(timer:inout String, endVar:inout Bool, winVar:inout Int, p1Life:inout Int, p2Life:inout Int) {
        timePointer = .init(&timer)
        endPointer = .init(&endVar)
        winPointer = .init(&winVar)
        //exP1LifePointer = .init(&p1Life)
        //exP2LifePointer = .init(&p2Life)
        //localP1LifePointer = .init(&self.player1Life)
        //localP2LifePointer = .init(&self.player2Life)
        
        super.init(name:"StatusBar")
    }

    /*func subtractLives (player:Int, lives:Int) {
        if (player == 1) {
            player1Life -= lives
        }
        else if (player == 2) {
            player2Life -= lives
        }
    }*/

    //links the game status, such as if ended or not and win state
    /*func linkStatusVariables(endVar:inout Bool, winVar:inout Int, p1Life:inout Int, p2Life:inout Int) {
        endPointer = .init(&endVar)
        winPointer = .init(&winVar)
        exP1LifePointer = .init(&p1Life)
        exP2LifePointer = .init(&p2Life)
    }*/
    
    override func render(canvas:Canvas) {
        let canvasSize = canvas.canvasSize!

        time = timePointer.pointee
        //every 30 executions, 1 second elapses
        if (count == 30) {
            count = 0
            var minutes = 0
            var seconds = 0
            
            //if the time remaining is greater than or equal to ten minutes
            if (time[time.index(time.startIndex, offsetBy:2)] == ":") {
                minutes = ((time[time.index(time.startIndex, offsetBy:0)].wholeNumberValue!) * 10) + time[time.index(time.startIndex, offsetBy:1)].wholeNumberValue!
            }
            else {
                minutes = time[time.index(time.startIndex, offsetBy:0)].wholeNumberValue!
            }
            seconds = (time[time.index(time.startIndex, offsetBy:((minutes < 10) ? 2 : 3))].wholeNumberValue! * 10) + time[time.index(time.startIndex, offsetBy:((minutes < 10) ? 3 : 4))].wholeNumberValue!

            seconds -= 1
            if (seconds < 0) {
                seconds += 60
                minutes -= 1
            }
            //the game has ended by time quota
            if (minutes < 0) {
                minutes = 0
                seconds = 0
                end = true
            }
            //this places a zero before the num of seconds in the time if necessary
            let zeroSec = (seconds < 10) ? 0 : Int(floor(Double(seconds) / 10.0))

            //updates the time string to display the new time
            time = "\(minutes):\(zeroSec)\(seconds % 10)"
            //localP1LifePointer.pointee -= 1
            //print("testing: " + String(localP1LifePointer.pointee))
            //StatusBar.player1Life -= 1
            //print("testing: " + String(StatusBar.player1Life))
        }
        //print("old: " + String(StatusBar.player1Life))
        //receives the life data
        //StatusBar.player1Life = exP1LifePointer.pointee
        //StatusBar.player2Life = exP2LifePointer.pointee

        timePointer.pointee = time
        
        if (StatusBar.player1Life <= 0) {
            end = true
            win = 2
        }
        else if (StatusBar.player2Life <= 0) {
            end = true
            win = 1
        }
        
        if (!end) {
        //render banner text
        let fillStyle = FillStyle(color:Color(.white))
        let words = Text(location:Point(x:25,y:50), text:"P1 Lives: \(StatusBar.player1Life)")
        words.font = "30pt Callout"
        canvas.render(fillStyle, words)

        let wordsTime = Text(location:Point(x:canvasSize.center.x-200,y:50), text:"Time Remaining: \(time)")
        wordsTime.font = "30pt Callout"
        canvas.render(wordsTime)
        
        let words1 = Text(location:Point(x:canvasSize.center.x+400,y:50), text:"P2 Lives: \(StatusBar.player2Life)")
        words1.font = "30pt Callout"
        canvas.render(words1)
        }
        else {
            //deletes the banner
            canvas.render()
            //send the end and win data
            endPointer.pointee = end
            winPointer.pointee = win
        }

        count += 1
        }
}
