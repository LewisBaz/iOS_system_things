//: [Previous](@previous)

import Foundation

class ThreadSafeArray<T> {
    private var array: [T] = []
    private let lock = NSLock()
    
    func append(_ newElement: T) {
        lock.lock()
        array.append(newElement)
        lock.unlock()
    }
    
    func get(at index: Int) -> T? {
        lock.lock()
        defer { lock.unlock() }
        return index < array.count ? array[index] : nil
    }
    
    var count: Int {
        lock.lock()
        defer { lock.unlock() }
        return array.count
    }
}

// Пример использования
let threadSafeArray = ThreadSafeArray<String>()

let group = DispatchGroup()

// Поток 1: добавление элементов
DispatchQueue.global().async(group: group) {
    for i in 1...10 {
        threadSafeArray.append("Thread 1 - \(i)")
    }
}

// Поток 2: добавление элементов
DispatchQueue.global().async(group: group) {
    for i in 1...10 {
        threadSafeArray.append("Thread 2 - \(i)")
    }
}

// Ожидание завершения всех потоков
group.wait()

// Проверка содержимого массива
for i in 0..<threadSafeArray.count {
    if let element = threadSafeArray.get(at: i) {
        print(element)
    }
}


//: [Next](@next)
