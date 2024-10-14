//: [Previous](@previous)

import Foundation

struct Point {
    let x, y: Double
    
    func draw() {
        
    }
}

func drawAPoint(_ point: Point) {
    point.draw()
}

let point = Point(x: 1, y: 1)
point.draw() // <- inlining

DispatchQueue.global()


drawAPoint(point)

//: [Next](@next)
