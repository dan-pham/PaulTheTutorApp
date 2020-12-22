//
//  Problem.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/10/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

struct Problem {
    var number: Int
    var operand1: Int
    var operand2: Int
    var operation: String
    var result: Int?
    var quotient: Int?
    var remainder: Int?
    
    var answer: String = ""
    var remainderAnswer: String = ""
    
    var isCorrect: Bool = false
    
    init(number: Int, operand1: Int, operand2: Int, operation: String, result: Int? = nil, quotient: Int? = nil, remainder: Int? = nil) {
        self.number = number
        self.operand1 = operand1
        self.operand2 = operand2
        self.operation = operation
        self.result = result
        self.quotient = quotient
        self.remainder = remainder
    }
    
    func printEquation() -> String {
        var equation = "\(operand1) \(operation) \(operand2) = \(answer)"
        
        if remainder != nil {
            equation += " R \(remainderAnswer)"
        }
        
        return equation
    }
}
