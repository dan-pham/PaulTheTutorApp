//
//  ProblemSet.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/10/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit
import Lottie

struct ProblemSet {
    var title: String
    var animation: Animation
    var numberOfProblems: Int
    var operation: String
    var problems: [Problem]?
    
    init(title: String, animation: Animation, numberOfProblems: Int, operation: String) {
        self.title = title
        self.animation = animation
        self.numberOfProblems = numberOfProblems
        self.operation = operation
    }
    
    mutating func generateProblems() {
        var newProblems: [Problem] = []
        
        for number in 1...numberOfProblems {
            let newProblem = generateRandomProblem(number: number, operation: operation)
            newProblems.append(newProblem)
        }
        
        problems = newProblems
    }
    
    private func generateRandomProblem(number: Int, operation: String) -> Problem {
        let maxRange = 100
        let operand1 = Int.random(in: 1...maxRange)
        let operand2 = operation == "-" ? Int.random(in: 0...operand1) : Int.random(in: 0...maxRange)
        var result = 0
        
        switch operation {
        case "+":
            result = operand1 + operand2
        case "-":
            result = operand1 - operand2
        default:
            break
        }
        
        return Problem(number: number, operand1: operand1, operand2: operand2, operation: operation, result: result)
    }
}
