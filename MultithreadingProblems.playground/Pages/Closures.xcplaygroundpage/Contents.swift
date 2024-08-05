//: [Previous](@previous)

class Person {
    var name: String
    var greeting: (() -> Void)?

    init(name: String) {
        self.name = name
        self.greeting = {
            print("Hello, \(name)")
        }
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}

func createPerson() {
    let person = Person(name: "John")
    person.name = "Lev"
    person.greeting?() 
}

createPerson()


//: [Next](@next)
