//: [Previous](@previous)

import Foundation

class Car {
    
    func startEngine() {
        prepareEngine()
    }
    
    private func prepareEngine() {
        print("Engine is prepared to start")
    }
}

class Tesla: Car {
    
    override func startEngine() {
        super.startEngine()
        print("Start \(String(describing: type(of: self))) electric engine")
    }
}


class Audi: Car {
    
    override func startEngine() {
        super.startEngine()
        print("Start \(String(describing: type(of: self))) gazoline engine")
    }
}

let tesla = Tesla()
tesla.startEngine()
let audi = Audi()
audi.startEngine()
let nissan = Car()
nissan.startEngine()

//: [Next](@next)

class Instrument {
    func play() {}
    func tune() {}
}

protocol Intrumentable {
    func play()
    func tune()
}

class Guitar: Instrument {
    override func play() {
        print("Guitar played")
    }
    override func tune() {
        print("Guitar tuned")
    }
}

class Piano: Intrumentable {
    func play() {
        print("Piano played")
    }
    func tune() {
        print("Piano tuned")
    }
}

let guitar = Guitar()
let piano = Piano()
guitar.play()
piano.tune()
