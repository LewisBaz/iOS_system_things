//: [Previous](@previous)

import Foundation

protocol P {}

extension P {
    func method() {
        print("from protocol")
    }
}

struct C: P {
    func method() {
        print("from class")
    }
}

let firstObject = C()
firstObject.method()

let secondObject: P = C()
secondObject.method()


//: [Next](@next)
