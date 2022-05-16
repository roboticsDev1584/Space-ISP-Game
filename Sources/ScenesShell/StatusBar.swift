import Foundation
import Igis
import Scenes

class StatusBar : RenderableEntity {
    //set up life and time variables
    var player1Life = 3
    var player2Life = 3
    var time = "0:00"

    //set up end state variables
    var count = 0
    var end = false
    var win = 0

    //share data with InteractionLayer using pointers
    var endPointer : UnsafeMutablePointer<Bool>
    var winPointer : UnsafeMutablePointer<Int>
    var timePointer : UnsafeMutablePointer<String>
    var p1LifePointer : UnsafeMutablePointer<Int>
    var p2LifePointer : UnsafeMutablePointer<Int>
    var p1ColorPointer : UnsafeMutablePointer<Color>
    var p2ColorPointer : UnsafeMutablePointer<Color>

    //initialize player life text color
    var p1LifeColor = Color(.white)
    var p2LifeColor = Color(.white)

    //need some way to indicate to InteractionLayer.swift that the game has ended
    init(timer:inout String, endVar:inout Bool, winVar:inout Int, p1Life:inout Int, p2Life:inout Int, p1Color:inout Color, p2Color:inout Color) {
        //initialize pointers
        timePointer = .init(&timer)
        endPointer = .init(&endVar)
        winPointer = .init(&winVar)
        p1LifePointer = .init(&p1Life)
        p2LifePointer = .init(&p2Life)
        p1ColorPointer = .init(&p1Color)
        p2ColorPointer = .init(&p2Color)
        
        super.init(name:"StatusBar")
    }

    //when a game ends, the status bar is deinitialized
    deinit {

    }

    override func render(canvas:Canvas) {
        //get size of canvas
        let canvasSize = canvas.canvasSize!

        //get current player colors
        p1LifeColor = p1ColorPointer.pointee
        p2LifeColor = p2ColorPointer.pointee

        //get current player lives
        player1Life = p1LifePointer.pointee
        player2Life = p2LifePointer.pointee

        //get curren time
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
        }

        //set the decremented time using a pointer
        timePointer.pointee = time

        //the game has ended by a player losing all lives
        if (player1Life == 0) {
            end = true
            win = 2
        }
        else if (player2Life == 0) {
            end = true
            win = 1
        }

        //if the game has not ended, render status bar
        if (!end) {
            //render banner text
            let fill = FillStyle(color:p1LifeColor)
            let words = Text(location:Point(x:25,y:50), text:"P1 Lives: \(player1Life)")
            words.font = "30pt Callout"
            canvas.render(fill, words)

            let fill1 = FillStyle(color:Color(.white))
            let wordsTime = Text(location:Point(x:canvasSize.center.x-200,y:50), text:"Time Remaining: \(time)")
            wordsTime.font = "30pt Callout"
            canvas.render(fill1, wordsTime)

            let fill2 = FillStyle(color:p2LifeColor)
            let words1 = Text(location:Point(x:canvasSize.width-225,y:50), text:"P2 Lives: \(player2Life)")
            words1.font = "30pt Callout"
            canvas.render(fill2, words1)
        }
        else {
            //deletes the banner
            canvas.render()
            
            //send the end and win data to InteractionLayer
            endPointer.pointee = end
            winPointer.pointee = win
        }

        //keep track of current time using count
        count += 1
    }
}
