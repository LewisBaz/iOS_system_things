//: [Previous](@previous)

import Foundation
import os.lock

class ProblemCounter {
    
    var count = 0
    
    func increment() {
        count += 1
    }
}

class SafeBySyncQueueCounter {
    
    private let queue = DispatchQueue(label: "sync.queue")
    
    private var count = 0
    
    var value: Int {
        queue.sync {
            return count
        }
    }
    
    func increment() {
        queue.sync {
            count += 1
        }
    }
}

class SafeByNSLockCounter {
    
    private let lock = NSLock()
    
    private var count = 0
    
    var value: Int {
        lock.lock()
        let currentValue = count
        lock.unlock()
        return currentValue
    }
    
    func increment() {
        lock.lock()
        count += 1
        lock.unlock()
    }
}

class SafeByBarrierCounter {
    
    private let queue = DispatchQueue(label: "barrier.queue", attributes: .concurrent)
    
    private var count = 0
    
    func increment() {
        queue.async(flags: .barrier) {
            self.count += 1
        }
    }
    
    var value: Int {
        return queue.sync { count }
    }
}

let counter = ProblemCounter()
let safeBySyncQueueCounter = SafeBySyncQueueCounter()
let safeByNSLockCounter = SafeByNSLockCounter()
let safeByBarrierCounter = SafeByBarrierCounter()
let globalQueue = DispatchQueue.global()

// Запускаем 1000 задач инкрементации в разных потоках
for _ in 0..<1000 {
    globalQueue.async {
        counter.increment()
        safeBySyncQueueCounter.increment()
        safeByNSLockCounter.increment()
        safeByBarrierCounter.increment()
    }
}

sleep(2)

print(counter.count)
print(safeBySyncQueueCounter.value)
print(safeByNSLockCounter.value)
print(safeByBarrierCounter.value)

//: [Next](@next)

//import Foundation
//import os.lock

class AtomicCounter {
    private var count = Int64(0)
    
    func increment() {
        OSAtomicIncrement64(&count)
    }
    
    var value: Int64 {
        return count
    }
}

let atomicCounter = AtomicCounter()

for _ in 0..<1000 {
    globalQueue.async {
        atomicCounter.increment()
    }
}

sleep(2)

print("Final count: \(atomicCounter.value)")
