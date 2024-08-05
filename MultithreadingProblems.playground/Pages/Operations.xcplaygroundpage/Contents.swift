//: [Previous](@previous)

import Foundation

let firstOperation = BlockOperation {
    print("First operation")
}

let secondOperation = BlockOperation {
    print("Second operation")
}

let thirdOperation = BlockOperation {
    print("Third operation")
}

let op = BlockOperation()
op.addExecutionBlock {
    print(op.hashValue)
}

let q = OperationQueue()
q.addOperation(op)

secondOperation.addDependency(firstOperation)
thirdOperation.addDependency(secondOperation)

let queue = OperationQueue()
queue.addOperations([firstOperation, secondOperation, thirdOperation], waitUntilFinished: false)

//: [Next](@next)
