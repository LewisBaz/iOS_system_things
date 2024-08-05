//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"

func unique(_ string: String) -> Int {
    var container = Set<Character>()
    string.lowercased().replacingOccurrences(of: " ", with: "").forEach({
        container.insert($0)
    })
    return container.count
}

let result = unique(greeting)
print(result)

//: [Next](@next)
