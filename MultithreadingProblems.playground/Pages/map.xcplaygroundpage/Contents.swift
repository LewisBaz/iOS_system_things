//: [Previous](@previous)

extension Array {
    
    func mymap<T>(_ transform: (Element) -> (T)) -> [T] {
        var result: [T] = []
        result.reserveCapacity(self.count)
        self.forEach {
            result.append(transform($0))
        }
        return result
    }
    
    func compactmap<T>(_ transform: (Element) -> (T?)) -> [T] {
        var result: [T] = []
        result.reserveCapacity(self.count)
        for element in self {
            if let value = transform(element) {
                result.append(value)
            }
        }
        return result
    }
}

var list: [Int?] = [1,2,nil,4,nil]
var list2 = list.compactmap { e in
    return e
}
print(list2)

var array: [Int?] = [1,2,nil,4,nil]
var array2 = list.mymap { e in
    return e
}
print(array2)

print([1,2,3,4,5].mymap { element in
    return String(element)
})

print(["1","1","2","1","2"].mymap { element in
    return Int(element)!
})

//: [Next](@next)
