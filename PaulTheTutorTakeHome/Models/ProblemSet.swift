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
    var parameters: ProblemSetParameters
    var problems: [Problem]?
    
    
    init(problemSetParameters: ProblemSetParameters) {
        parameters = problemSetParameters
    }
    
    mutating func generateProblems() {
        var newProblems: [Problem] = []
        
        for number in 1...parameters.numberOfProblems {
            let newProblem = generateRandomProblem(number: number, parameters: parameters)
            newProblems.append(newProblem)
        }
        
        problems = newProblems
    }
    
    private func generateRandomProblem(number: Int, parameters: ProblemSetParameters) -> Problem {
        let minRange = calculateMinRange()
        let maxRange = calculateMaxRange()
        var operand1 = generateOperand1(minRange: minRange, maxRange: maxRange)
        var operand2 = generateOperand2(minRange: minRange, maxRange: maxRange, operand1: operand1)
        
        if parameters.operation == .subtraction && (parameters.integerSign == .positive || parameters.integerType == .doubles) {
            if operand1 < operand2 {
                let temp = operand2
                operand2 = operand1
                operand1 = temp
            }
            
            let result = operand1 - operand2
            return Problem(number: number, operand1: operand1, operand2: operand2, operation: parameters.operation.rawValue, integerResult: result)
        } else if parameters.divisionType == .even {
            let temp = operand2
            operand2 = operand1
            operand1 = temp
            let result = operand1 / operand2
            return Problem(number: number, operand1: operand1, operand2: operand2, operation: parameters.operation.rawValue, integerResult: result)
        } else if parameters.divisionType == .remainders {
            let temp = operand2
            operand2 = operand1
            operand1 = temp
            let quotient = operand1 / operand2
            let remainder = operand1 % operand2
            return Problem(number: number, operand1: operand1, operand2: operand2, operation: parameters.operation.rawValue, quotient: quotient, remainder: remainder)
        } else if parameters.divisionType == .decimals {
            let temp = operand2
            operand2 = operand1
            operand1 = temp
            let result = (Double(operand1) / Double(operand2)).round(toPlaces: 2)
            return Problem(number: number, operand1: operand1, operand2: operand2, operation: parameters.operation.rawValue, decimalResult: result)
        } else {
            let result = generateResult(operand1: operand1, operand2: operand2)
            return Problem(number: number, operand1: operand1, operand2: operand2, operation: parameters.operation.rawValue, integerResult: result)
        }
    }
    
    private func calculateMinRange() -> Int {
        let minRange: Int
        switch parameters.integerType {
        case .doubles:
            minRange = 1
        case .oneDigit:
            minRange = 1
        case .hardOneDigits:
            minRange = 4
        case .zeroToTwelve:
            minRange = 0
        case .oneToTwoDigits:
            minRange = 1
        case .multipleDigits:
            minRange = 10
        case .focusOnANumber:
            minRange = 0
        case .pickTheRange:
            minRange = 0
        }
        
        return minRange
    }
    
    private func calculateMaxRange() -> Int {
        let maxRange: Int
        switch parameters.integerType {
        case .doubles:
            maxRange = 9
        case .oneDigit:
            maxRange = 9
        case .hardOneDigits:
            maxRange = 9
        case .zeroToTwelve:
            maxRange = 12
        case .oneToTwoDigits:
            maxRange = 99
        case .multipleDigits:
            maxRange = 999
        case .focusOnANumber:
            maxRange = 999
        case .pickTheRange:
            maxRange = 999
        }
        
        return maxRange
    }
    
    private func generateOperand1(minRange: Int, maxRange: Int) -> Int {
        var operand1: Int
        
        if parameters.integerType == .pickTheRange, let firstNumberMin = parameters.firstNumberMin, let firstNumberMax = parameters.firstNumberMax {
            operand1 = Int.random(in: firstNumberMin...firstNumberMax)
        } else if parameters.integerType == .focusOnANumber, let focusNumber = parameters.focusNumber {
            operand1 = focusNumber
        } else if parameters.integerSign == .positive {
            operand1 = Int.random(in: minRange...maxRange)
        } else {
            operand1 = Bool.random() ? -Int.random(in: minRange...maxRange) : Int.random(in: minRange...maxRange)
        }
        
        if parameters.divisionType != nil && operand1 == 0 { return 1 }
        
        return operand1
    }
    
    private func generateOperand2(minRange: Int, maxRange: Int, operand1: Int) -> Int {
        let operand2: Int
        
        if parameters.integerType == .doubles {
            if parameters.operation == .subtraction || parameters.operation == .division {
                operand2 = operand1 * 2
            } else {
                operand2 = operand1
            }
        } else if parameters.divisionType == .even {
            operand2 = operand1 * Int.random(in: minRange...maxRange)
        } else if parameters.integerType == .pickTheRange, let secondNumberMin = parameters.secondNumberMin, let secondNumberMax = parameters.secondNumberMax {
            operand2 = Int.random(in: secondNumberMin...secondNumberMax)
        } else if parameters.integerType == .focusOnANumber, let otherNumberMin = parameters.otherNumberMin, let otherNumberMax = parameters.otherNumberMax {
            operand2 = Int.random(in: otherNumberMin...otherNumberMax)
        } else if parameters.integerSign == .positive {
            operand2 = Int.random(in: minRange...maxRange)
        } else {
            operand2 = Bool.random() ? -Int.random(in: minRange...maxRange) : Int.random(in: minRange...maxRange)
        }
        
        return operand2
    }
    
    private func generateResult(operand1: Int, operand2: Int) -> Int {
        let result: Int
        
        switch parameters.operation {
        case .addition:
            result = operand1 + operand2
        case .subtraction:
            result = operand1 - operand2
        case .multiplication:
            result = operand1 * operand2
        case .division:
            result = operand1 / operand2
        }
        
        return result
    }
    
}

class ProblemSetParameters {
    
    static let shared = ProblemSetParameters()
    
    var numberType: NumberType = .integers
    var operation: Operation = .addition
    var divisionType: DivisionType?
    var integerType: IntegerType = .oneDigit
    var integerSign: IntegerSign = .positive
    var numberOfProblems: Int = 0
    
    var focusNumber: Int?
    var otherNumberMin: Int?
    var otherNumberMax: Int?
    
    var firstNumberMin: Int?
    var firstNumberMax: Int?
    var secondNumberMin: Int?
    var secondNumberMax: Int?
    
    
    private init() { }
    
    enum NumberType {
        case integers
    }

    enum Operation: String {
        case addition = "+"
        case subtraction = "-"
        case multiplication = "x"
        case division = "÷"
    }
    
    enum DivisionType {
        case even
        case remainders
        case decimals
    }
    
    enum IntegerType {
        case doubles
        case oneDigit
        case hardOneDigits
        case zeroToTwelve
        case oneToTwoDigits
        case multipleDigits
        case focusOnANumber
        case pickTheRange
    }
    
    enum IntegerSign {
        case positive
        case negativeAndPositive
    }
}

class PTResult {
    var integer: Int?
    var remainder: Int?
    var decimal: Double?
}
