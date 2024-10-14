//: [Previous](@previous)

import Foundation

extension Array {
    
    func countWhere(action: (Element) -> Bool) -> Int {
        var result = 0
        return self.reduce(result) { iterator, element in
            if action(element) { result += 1 }
            return result
        }
    }
}

extension Array {
    
    func count(where predicate: (Element) -> Bool) -> Int {
        return self.filter(predicate).count
    }
}

print([1,2,3,4,5].countWhere { element in
    return element % 2 == 0
})

print(["1","1","2","1","2"].countWhere { element in
    return element != "2"
})

//: [Next](@next)
