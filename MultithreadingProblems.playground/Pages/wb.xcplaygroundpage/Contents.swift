//: [Previous](@previous)

import Foundation

protocol Weapon {
    
    associatedtype Kind: Equatable
    
    func getKind() -> Kind
}

struct Saber: Weapon {
    typealias Kind = String
    func getKind() -> Kind {
        "Siber"
    }
}

struct Gun: Weapon {
    typealias Kind = [Character]
    func getKind() -> Kind {
        ["G", "u", "n"]
    }
}

func compareContainerValue<C1: Weapon, C2: Weapon>(container1: C1, container2: C2) -> Bool where C1.Kind == C2.Kind {
    container1.getKind() == container2.getKind()
}

print(compareContainerValue(container1: Saber(), container2: Gun()))

// -----

//enum MyOptional<T: Equatable>: Equatable {
//    case value(T)
//    case none
//    
//    static func ==(lhs: MyOptional<T>, rhs: MyOptional<T>) -> Bool {
//        switch (lhs, rhs) {
//        case (.none, .none):
//            return true
//        case let (.value(left), .value(right)):
//            return left == right
//        default:
//            return false
//        }
//    }
//}
//
//let a = MyOptional.value(5)
//let b = MyOptional.value("ff")
//let с = MyOptional.value(5)
//
//print(a == с)
//    
//    
//    
//}
//
///// ---------
//
//var array = [0, 1, 2]
//
//for i in 3...10_000_000_000 { // Условно много раз добавляем в конце элементы
//    array.append(i)
//}
//
//
//// --------------------
//
//struct Student: Hashable {
//    var uniqueId: Int
//    var name: String
//}
//
//let peoples: [Student] = [Student(uniqueId: 12345, name: "Vasya"), Student(uniqueId: 2, name: "Petya")]
//
//final class Students {
//
//    var studentsStorage: [Int: Student] = [:]
//    
//    init(students: [Student]) {
//        saveToStorage(students)
//    }
//    
//    private func saveToStogare(_ students: [Student]) {
//        students.forEach {
//            studentsStorage[$0.id] = $0
//        }
//    }
//    
//    public func searchStudent(by id: Int) -> Student? {
//        return studentsStorage[id]
//    }
//}
//
//let student = Students(students: peoples)
//
//student.searchStudent(by: 5)
//
///// ------
//
//// MARK: - Dictionary + Optional
//
//var dict: [String: Int?] = [
//    "one": 1,
//    "two": 2,
//    "none": nil
//]
//
//print(dict.count) // 3
//
//dict["two"] = nil
//dict["none"] = .value(nil)
//
//print(dict.count) // 1
//
//var a = dict["one"] // какой тип?
//
//var dict2: [String: Double] = [:]
//var b = dict2["one"] // какой тип? Double?
//
//
//
////---------------
//
//
//class Person {
//
//    var name: String = "Bill"
//
//    func sayHello() {
//        doAction {
//            print("Hello my name is \(self.name)")
//        }
//    }
//
//    private func doAction(closure: @escaping () -> Void) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            closure()
//        }
//    }
//
//    deinit {
//        print("People deiniting")
//    }
//}
//
//weak var people: People? = People()
//people?.sayHello()
//people = nil
//
//// Hello my name is Bill
//// deinit
//
////------------------
//
//
//// MARK: - I
//
//var a = 0
//var b = 0
//
//let closure = { [a] in
//    print(a, b)
//}
//
//a = 10
//b = 10
//
//closure() // 0 10
//
//print(a)
//
//
//// MARK: - II
//
//class C {
//    var value = 0
//}
//
//let a2 = C()
//let b2 = C()
//
//let closure2 = { [a2] in
//    print(a2.value, b2.value)
//}
//
//a2.value = 10
//b2.value = 10
//
//closure2() // 10 10
//
//
////---------------------------------------------
//
//
//
//// 1
//DispatchQueue.main.async {
//    print("1")
//
//    DispatchQueue.global().async {
//        print("2")
//    }
//
//    print("3")
//}
//
//print("4")
//
//// 4 1 2 3
//
//
//// 2
//DispatchQueue.main.async {
//    print("1")
//
//    DispatchQueue.main.sync {
//        print("2")
//    }
//
//    print("3")
//}
//
//print("4")
//
//// 4 1 deadlock
//
//
//// 3
//DispatchQueue.global().async {
//    print("1")
//
//    DispatchQueue.main.sync {
//        print("2")
//    }
//
//    print("3")
//}
//
//print("4")
//
//// 4 1 2 3
//
//
////-------
//
//var count = 0
//let lock = NSLock()
//let group = DispatchGroup()
//
//group.enter()
//let thread1 = Thread {
//    for _ in 0...999 {
//        lock.lock()
//        count += 1
//        lock.unlock()
//    }
//    group.leave()
//}
//
//group.enter()
//let thread2 = Thread {
//    for _ in 0...999 {
//        lock.lock()
//        count += 1
//        lock.unlock()
//    }
//    group.leave()
//}
//
//thread1.start()
//thread2.start()
//
//group.notify(queue: .global()) {
//    print(count)
//}
//
//
////: [Next](@next)
