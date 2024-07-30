//: [Previous](@previous)

import Foundation

var count = 0 

let thread1 = Thread { for _ in 0...999 { count += 1 } }
let thread2 = Thread { for _ in 0...999 { count += 1 } }
thread1.start()
thread2.start()

sleep(2)

print(count)

//: [Next](@next)
