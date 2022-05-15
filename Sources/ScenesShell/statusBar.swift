import Scenes
import Igis
import Foundation

class StatusBar : RenderableEntity {
    var player1Life = 3
    var player2Life = 3
    var time = "0:00"
    
    var count = 0
    var end = false
    var win = 0

    var endPointer : UnsafeMutablePointer<Bool>
    var winPointer : UnsafeMutablePointer<Int>
    var timePointer : UnsafeMutablePointer<String>
    var p1LifePointer : UnsafeMutablePointer<Int>
    var p2LifePointer : UnsafeMutablePointer<Int>
    var p1Address : Int
    var p2Address : Int

    //need some way to indicate to InteractionLayer.swift that the game has ended
    init(timer:inout String, endVar:inout Bool, winVar:inout Int, p1Life:inout Int, p2Life:inout Int) {
        timePointer = .init(&timer)
        endPointer = .init(&endVar)
        winPointer = .init(&winVar)
        p1LifePointer = .init(&p1Life)
        p2LifePointer = .init(&p2Life)
        p1Address = p1Life
        p2Address = p2Life
        super.init(name:"StatusBar")
    }

    //when a game ends, status bar is deinitialized
    deinit {

    }

    override func render(canvas:Canvas) {
        let canvasSize = canvas.canvasSize!

        //make sure that lives are reset properly on first execution
        //if (count == 0) {
        //    p1LifePointer.pointee = 3
        //    p2LifePointer.pointee = 3
        //}

        //this securely creates a pointer that updates the life value
        //if ((p1LifePointer.pointee > 0) && (p2LifePointer.pointee > 0)) {
        let testing = withUnsafeMutablePointer(to: &p1Address) { response -> Int in
            /*var p1LifePointer = UnsafeMutablePointer<Int>.allocate(capacity:1)
            p1LifePointer.initialize(from:&p1Address, count:1)
            p1LifePointer.pointee = 3*/
            let test = response.pointee
            //player1Life = response.pointee
            //print("Changed life value1")
            //print("Response: \(response.pointee)")
            return test
        }
        //print(testing)
        let testing2 = withUnsafeMutablePointer(to: &p2Address) { response -> Int in 
            /*var p2LifePointer = UnsafeMutablePointer<Int>.allocate(capacity:1)
            p2LifePointer.initialize(from:&p2Address, count:1)
            p2LifePointer.pointee = 3*/
            //player2Life = response.pointee
            let test = response.pointee
            //print(player2Life)
            //print("Changed life value2")
            //print("Response: \(response)")
            return test
        }
        //print(testing2)
        //print("p2Life: \(player2Life)")
        player1Life = p1LifePointer.pointee
        player2Life = p2LifePointer.pointee
        //}
        
        time = timePointer.pointee
        //print("p2Life \(player2Life)")
        
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

        timePointer.pointee = time
        
        if (player1Life == 0) {
            end = true
            win = 2
        }
        else if (player2Life == 0) {
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
        
        let words1 = Text(location:Point(x:canvasSize.width-225,y:50), text:"P2 Lives: \(player2Life)")
        words1.font = "30pt Callout"
        canvas.render(words1)
        }
        else {
            //deletes the banner
            canvas.render()
            //send the end and win data
            endPointer.pointee = end
            winPointer.pointee = win
            //p1LifePointer.pointee = 3
            //p1LifePointer.pointee = 3
        }

        count += 1
    }
}
