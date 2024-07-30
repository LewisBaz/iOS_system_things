import Foundation

let lock1 = NSLock()
let lock2 = NSLock()

let queue = DispatchQueue(label: "deadlock_queue", attributes: .concurrent)

func task1() {
    queue.async {
        lock1.lock()
        print("Lock 1 locked from 1 task")
        
        sleep(1)
        print("Task 1")
        
        lock2.lock()
        print("Lock 2 locked form 1 task")
        
        print("Thread 1")
        
        lock2.unlock()
        print("Lock 2 unlocked from 1 task")
        
        lock1.unlock()
        print("Lock 1 unlocked from 1 task")
    }
}

func task2() {
    queue.async {
        lock2.lock()
        print("Lock 2 locked from 2 task")
        
        sleep(1)
        print("Task 2")
        
        lock1.lock()
        print("Lock 2 locked from 2 task")
        
        print("Thread 2")
        
        lock1.unlock()
        print("Lock 1 unlocked from 2 task")
        
        lock2.unlock()
        print("Lock 2 unlocked from 2 task")
    }
}

task1()
task2()
