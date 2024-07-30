//: [Previous](@previous)
//
//import Foundation
//
//class ResourceStarvationExample {
//    private let semaphore = DispatchSemaphore(value: 1)
//    
//    func accessResource(threadName: String) {
//        if semaphore.wait(timeout: .now() + 1) == .success {
//            print("\(threadName) acquired lock")
//            sleep(2) // Симуляция длительной работы
//            print("\(threadName) releasing lock")
//            semaphore.signal()
//        } else {
//            print("\(threadName) could not acquire lock and is starving")
//        }
//    }
//}
//
//let resourceExample = ResourceStarvationExample()
//
//// Высокоприоритетная очередь, которая захватывает ресурс
//let highPriorityQueue = DispatchQueue.global(qos: .userInitiated)
//
//// Низкоприоритетная очередь, которая пытается захватить ресурс, но может голодать
//let lowPriorityQueue = DispatchQueue.global(qos: .background)
//
//// Запускаем несколько высокоприоритетных потоков, которые будут постоянно захватывать ресурс
//for i in 1...10 {
//    highPriorityQueue.async {
//        let threadName = "High Priority Thread \(i)"
//        while true {
//            resourceExample.accessResource(threadName: threadName)
//            usleep(100_000) // Короткая пауза перед следующим захватом
//        }
//    }
//}
//
//// Запускаем несколько низкоприоритетных потоков, которые могут голодать
//for i in 1...3 {
//    lowPriorityQueue.async {
//        let threadName = "Low Priority Thread \(i)"
//        while true {
//            resourceExample.accessResource(threadName: threadName)
//            usleep(100_000) // Короткая пауза перед следующим захватом
//        }
//    }
//}
//
//// Даем время для выполнения всех задач
//sleep(10)
//print("Execution finished")
//
//
////: [Next](@next)
import Foundation

class FairResourceAccessExample {
    private let semaphore = DispatchSemaphore(value: 1)
    private let accessQueue = DispatchQueue(label: "com.example.fairAccessQueue", attributes: .concurrent)
    
    func accessResource(threadName: String) {
        accessQueue.async(flags: .barrier) {
            if self.semaphore.wait(timeout: .now() + 1) == .success {
                print("\(threadName) acquired lock")
                sleep(2) // Симуляция длительной работы
                print("\(threadName) releasing lock")
                self.semaphore.signal()
            } else {
                print("\(threadName) could not acquire lock and is waiting")
            }
        }
    }
}

let fairResourceExample = FairResourceAccessExample()

// Высокоприоритетная очередь
let highPriorityQueue = DispatchQueue.global(qos: .userInitiated)

// Низкоприоритетная очередь
let lowPriorityQueue = DispatchQueue.global(qos: .background)

// Запускаем несколько высокоприоритетных потоков
for i in 1...10 {
    highPriorityQueue.async {
        let threadName = "High Priority Thread \(i)"
        while true {
            fairResourceExample.accessResource(threadName: threadName)
            usleep(100_000) // Короткая пауза перед следующим захватом
        }
    }
}

// Запускаем несколько низкоприоритетных потоков
for i in 1...3 {
    lowPriorityQueue.async {
        let threadName = "Low Priority Thread \(i)"
        while true {
            fairResourceExample.accessResource(threadName: threadName)
            usleep(100_000) // Короткая пауза перед следующим захватом
        }
    }
}

// Даем время для выполнения всех задач
sleep(10)
print("Execution finished")
