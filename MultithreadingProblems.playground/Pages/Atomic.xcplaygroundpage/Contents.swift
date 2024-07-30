//: [Previous](@previous)

import Foundation

class Atomic<T> {
    private var value: T
    private let queue = DispatchQueue(label: "com.example.atomicQueue", attributes: .concurrent)
    
    init(_ value: T) {
        self.value = value
    }
    
    func get() -> T {
        return queue.sync {
            value
        }
    }
    
    func set(_ newValue: T) {
        queue.async(flags: .barrier) {
            self.value = newValue
        }
    }
    
    func mutate(_ transform: @escaping (inout T) -> Void) {
        queue.async(flags: .barrier) {
            transform(&self.value)
        }
    }
}

// Пример использования
let atomicInt = Atomic(0)

DispatchQueue.concurrentPerform(iterations: 1000) { _ in
    atomicInt.mutate { $0 += 1 }
}

sleep(1) // Даем время для завершения всех операций
print("Final value: \(atomicInt.get())") // Ожидаемое значение: 1000


//: [Next](@next)
