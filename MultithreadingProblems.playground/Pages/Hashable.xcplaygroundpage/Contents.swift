//: [Previous](@previous)

import Foundation

class KeyObject: Hashable {
    static func == (lhs: KeyObject, rhs: KeyObject) -> Bool {
        return lhs.a == rhs.a
    }
    
    let a: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }
    
    init(a: Int) {
        self.a = a
    }
}

let key1 = KeyObject(a: 1)
let key2 = KeyObject(a: 2)
//
var dict = [KeyObject: String]()
dict[key1] = "hi"
print(dict[key2], dict[key1])

/// Функция hash(into hasher: inout Hasher) делает одинаковое хэш-значение, в таком случае сравнение происходит непосредственно с помощью Equtable 

//: [Next](@next)
