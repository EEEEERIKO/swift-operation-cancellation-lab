//
//  main.swift
//  OperationCancellationLab
//
//  Created by Erik Valencia Cardona on 27/10/26.
//

import Foundation

final class OperationCancellationLab {
    
    private let operationQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.name = "com.example.operation-cancellation-lab"
        queue.maxConcurrentOperationCount = 2
        return queue
    }()
    
    private func createOperations(
        useDependency: Bool
    ) -> (operationA: BlockOperation, operationB: BlockOperation) {
        
        let operationB = BlockOperation {
            print("Operation B started")
            
            for _ in 0..<1000000 {
                // simulating long task
            }
            
            print("Operation B finished")
        }
        
        
        let operationA = BlockOperation {
            print("Operation A started")
            
            // a cancells b
            operationB.cancel()
            print("Operation A cancelled Operation B")
            
            for _ in 0..<1000000 {
                //simulaitng long tasl
            }
            
            print("Operation A finished")
            
        }
        
        if useDependency {
            operationB.addDependency(operationA)
        }
        
        return (operationA, operationB)
    }
    
    func runExperiment(useDependency: Bool) {
        let (operationA, operationB) = createOperations(
            useDependency: useDependency
        )
        
        print("""
                
                ===== EXPERIMENT =====
                B depends on A: \(useDependency)
                ======================
                """)
        
        operationQueue.addOperations(
            [operationA, operationB],
            waitUntilFinished: true
        )
        
        print("operation B cancelled: \(operationB.isCancelled)")
        print("All operations finished\n")
    }
}

let lab = OperationCancellationLab()

lab.runExperiment(useDependency: true)

lab.runExperiment(useDependency: false)
