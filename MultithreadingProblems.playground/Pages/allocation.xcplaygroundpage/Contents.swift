//: [Previous](@previous)
import Foundation

enum Color {
    case blue, gray, green
}
enum Orientation {
    case left, right
}
enum Tail {
    case bubble, tail, none
}
struct Attributes {
    let color: Color
    let orientation: Orientation
    let tail: Tail
}
var time = 0.0
for _ in 1...1000000 {
    let start = CFAbsoluteTimeGetCurrent()
    _ = "\(Color.blue)\(Orientation.left)\(Tail.bubble)"
    let diff = CFAbsoluteTimeGetCurrent() - start
    time += diff
}
        
print("Time of String exticution: \(time * 1000) mili seconds")
time = 0.0

for _ in 1...1000000 {
    let start = CFAbsoluteTimeGetCurrent()
    _ = Attributes(color: Color.blue, orientation: Orientation.left, tail: Tail.bubble)
    let diff = CFAbsoluteTimeGetCurrent() - start
    time += diff
}
print("Time of Struct exticution: \(time * 1000) mili seconds")

//: [Next](@next)

let t  = String()

var x, y: Int
