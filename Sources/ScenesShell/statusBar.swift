import Scenes
import Igis
import Foundation

class StatusBar : RenderableEntity {
    var player1Life : Int
    var player2Life : Int
    var time : String
    var count = 0
    var end = false
    var win = 0

    //need some way to indicate to InteractionLayer.swift that the game has ended
    init(s1Life:Int, s2Life:Int, time:String) {
        self.player1Life = s1Life
        self.player2Life = s2Life
        self.time = time
        super.init(name:"StatusBar")
    }

    func subtractLives (player:Int, lives:Int) {
        if (player == 1) {
            player1Life -= lives
        }
        else if (player == 2) {
            player2Life -= lives
        }
    }

    //returns the game status, such as if ended or not and win state
    func updateGameStatus(endVar:inout Bool, winVar:inout Int) {
        endVar = end
        winVar = win
    }
    
    override func render(canvas:Canvas) {
        let canvasSize = canvas.canvasSize!

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
        }
        if (player1Life <= 0) {
            end = true
            win = 2
        }
        else if (player2Life <= 0) {
            end = true
            win = 1
        }

        if (!end) {
        //render banner text
        let fillStyle = FillStyle(color:Color(.white))
        let words = Text(location:Point(x:25,y:50), text:"P1 Lives: \(player1Life)")
        words.font = "30pt Callout"
        canvas.render(fillStyle, words)

        let wordsTime = Text(location:Point(x:canvasSize.center.x-200,y:50), text:"Time Remaining: \(time)")
        wordsTime.font = "30pt Callout"
        canvas.render(wordsTime)
        
        let words1 = Text(location:Point(x:canvasSize.center.x+400,y:50), text:"P2 Lives: \(player2Life)")
        words1.font = "30pt Callout"
        canvas.render(words1)
        }
        else {
            //deletes the banner
            canvas.render()
        }

        count += 1
        }
}