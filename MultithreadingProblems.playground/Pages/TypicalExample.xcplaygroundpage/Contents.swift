//: [Previous](@previous)

import Foundation

let mainQueue = DispatchQueue.main
let globalQueue = DispatchQueue.global()
let serialQueue1 = DispatchQueue(label: "com.example.serialQueue1")
let serialQueue2 = DispatchQueue(label: "com.example.serialQueue2")
let concurrentQueue1 = DispatchQueue(label: "com.example.concurrentQueue1", attributes: .concurrent)
let concurrentQueue2 = DispatchQueue(label: "com.example.concurrentQueue2", attributes: .concurrent)

serialQueue1.sync {
    print(1)
    serialQueue1.async {
        print(2)
    }
    print(3)
    globalQueue.async {
        print(4)
    }
    print(5)
}
print(6)


//: [Next](@next)
