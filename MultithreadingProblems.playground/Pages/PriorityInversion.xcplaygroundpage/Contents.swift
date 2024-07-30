//: [Previous](@previous)

import Foundation

class Resource {
    private let lock = NSLock()
    
    func useResource() {
        lock.lock()
        print("\(Thread.current.name ?? "Thread") acquired lock")
        sleep(2) // Симуляция длительной работы
        print("\(Thread.current.name ?? "Thread") releasing lock")
        lock.unlock()
    }
}

// Создаем ресурс
let resource = Resource()

// Низкоприоритетный поток захватывает замок и удерживает его
let lowPriorityQueue = DispatchQueue.global(qos: .background)
lowPriorityQueue.async {
    Thread.current.name = "Low Priority Thread"
    resource.useResource()
}

// Даем время для того, чтобы низкоприоритетный поток захватил замок
sleep(1)

// Высокоприоритетный поток пытается захватить тот же замок
let highPriorityQueue = DispatchQueue.global(qos: .userInitiated)
highPriorityQueue.async {
    Thread.current.name = "High Priority Thread"
    resource.useResource()
}

// Даем время для выполнения всех задач
sleep(5)
print("Execution finished")


//: [Next](@next)
