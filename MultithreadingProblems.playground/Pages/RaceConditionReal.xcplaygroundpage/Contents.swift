//: [Previous](@previous)

import Foundation

class TicketSystem {
    var availableTickets = 1
    
    func buyTicket() -> Bool {
        if availableTickets > 0 {
            usleep(100) // Симуляция задержки
            availableTickets -= 1
            return true
        }
        return false
    }
}

let ticketSystem = TicketSystem()
let queue = DispatchQueue.global()

// Попытка купить билет одновременно двумя потоками
queue.async {
    if ticketSystem.buyTicket() {
        print("Thread 1 successfully bought a ticket.")
    } else {
        print("Thread 1 failed to buy a ticket.")
    }
}

queue.async {
    if (ticketSystem.buyTicket()) {
        print("Thread 2 successfully bought a ticket.")
    } else {
        print("Thread 2 failed to buy a ticket.")
    }
}

sleep(1)
print("Tickets left: \(ticketSystem.availableTickets)")

class SafeTicketSystem {
    var availableTickets = 1
    private let lock = NSLock()
    
    func buyTicket() -> Bool {
        lock.lock()
        defer { lock.unlock() }
        
        if availableTickets > 0 {
            usleep(100) // Симуляция задержки
            availableTickets -= 1
            return true
        }
        return false
    }
}

let safeTicketSystem = SafeTicketSystem()

queue.async {
    if safeTicketSystem.buyTicket() {
        print("Thread 1 successfully bought a ticket.")
    } else {
        print("Thread 1 failed to buy a ticket.")
    }
}

queue.async {
    if safeTicketSystem.buyTicket() {
        print("Thread 2 successfully bought a ticket.")
    } else {
        print("Thread 2 failed to buy a ticket.")
    }
}

sleep(1)
print("Tickets left: \(safeTicketSystem.availableTickets)")


//: [Next](@next)
