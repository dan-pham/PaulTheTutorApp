//
//  Problem.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/10/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

struct Problem: Equatable {
    var number: Int
    var operand1: Int
    var operand2: Int
    var operation: String
    var integerResult: Int?
    var quotient: Int?
    var remainder: Int?
    var decimalResult: Double?
    
    var answer: String = ""
    var remainderAnswer: String = ""
    
    var isCorrect: Bool = false
    
    init(number: Int, operand1: Int, operand2: Int, operation: String, integerResult: Int? = nil, quotient: Int? = nil, remainder: Int? = nil, decimalResult: Double? = nil) {
        self.number = number
        self.operand1 = operand1
        self.operand2 = operand2
        self.operation = operation
        self.integerResult = integerResult
        self.quotient = quotient
        self.remainder = remainder
        self.decimalResult = decimalResult
    }
    
    func printEquation() -> String {
        var equation = "\(operand1) \(operation) \(operand2) = \(answer)"
        
        if remainder != nil {
            equation += " R \(remainderAnswer)"
        }
        
        return equation
    }
    
    static func ==(lhs: Problem, rhs: Problem) -> Bool {
        let lhsEquation = "\(lhs.operand1) \(lhs.operation) \(lhs.operand2) = \(lhs.answer)"
        let rhsEquation = "\(rhs.operand1) \(rhs.operation) \(rhs.operand2) = \(rhs.answer)"
        return lhsEquation == rhsEquation
    }
}
