//: [Previous](@previous)

import Foundation

enum MyOptional<T> {
    case some(T)
    case none
    
    init(_ value: T?) {
        if let value = value {
            self = .some(value)
        } else {
            self = .none
        }
    }
    
    func unwrap() -> T? {
        switch self {
        case .some(let value):
            return value
        case .none:
            return nil
        }
    }
}

let value: Int? = 5
let myOptionalValue = MyOptional(value)
print(myOptionalValue)

let nilValue: Int? = nil
let myOptionalNil = MyOptional(nilValue)
print(myOptionalNil)

if let unwrapped = myOptionalValue.unwrap() {
    print(unwrapped)
}

//: [Next](@next)
