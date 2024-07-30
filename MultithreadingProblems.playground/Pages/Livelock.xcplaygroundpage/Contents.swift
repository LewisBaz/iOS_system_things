//: [Previous](@previous)

import Foundation

class Resource {
    private let lock = NSLock()
    private var isLocked = false
    
    func tryLock() -> Bool {
        if lock.try() {
            isLocked = true
            return true
        }
        return false
    }
    
    func unlock() {
        isLocked = false
        lock.unlock()
    }
    
    var locked: Bool {
        return isLocked
    }
}

let resource1 = Resource()
let resource2 = Resource()

func thread1() {
    while true {
        if resource1.tryLock() {
            print("Thread 1 locked resource 1")
            
            // Попробуем захватить второй ресурс
            if resource2.tryLock() {
                print("Thread 1 locked resource 2")
                
                // Обе блокировки успешны, выполняем работу
                print("Thread 1 working with both resources")
                
                // Освобождаем ресурсы
                resource2.unlock()
                resource1.unlock()
                break
            } else {
                // Если не удалось захватить ресурс 2, освобождаем ресурс 1
                print("Thread 1 could not lock resource 2, unlocking resource 1")
                resource1.unlock()
            }
        }
        
        // Делаем паузу перед повторной попыткой
        usleep(100_000)
    }
}

func thread2() {
    while true {
        if resource2.tryLock() {
            print("Thread 2 locked resource 2")
            
            // Попробуем захватить первый ресурс
            if resource1.tryLock() {
                print("Thread 2 locked resource 1")
                
                // Обе блокировки успешны, выполняем работу
                print("Thread 2 working with both resources")
                
                // Освобождаем ресурсы
                resource1.unlock()
                resource2.unlock()
                break
            } else {
                // Если не удалось захватить ресурс 1, освобождаем ресурс 2
                print("Thread 2 could not lock resource 1, unlocking resource 2")
                resource2.unlock()
            }
        }
        
        // Делаем паузу перед повторной попыткой
        usleep(100_000)
    }
}

let queue1 = DispatchQueue(label: "com.example.queue1")
let queue2 = DispatchQueue(label: "com.example.queue2")

queue1.async {
    thread1()
}

queue2.async {
    thread2()
}

sleep(5) // Даем время для выполнения потоков


//: [Next](@next)
