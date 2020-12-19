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
        
//        let operand1: Int
//        if parameters.integerType == .pickTheRange, let firstNumberMin = parameters.firstNumberMin, let firstNumberMax = parameters.firstNumberMax {
//            operand1 = Int.random(in: firstNumberMin...firstNumberMax)
//        } else if parameters.integerType == .focusOnANumber, let focusNumber = parameters.focusNumber {
//            operand1 = focusNumber
//        } else if parameters.integerSign == .positive {
//            operand1 = Int.random(in: minRange...maxRange)
//        } else {
//            operand1 = Bool.random() ? -Int.random(in: minRange...maxRange) : Int.random(in: minRange...maxRange)
//        }
//
//        let operand2: Int
//        if parameters.integerType == .doubles {
//            operand2 = operand1
//        } else if parameters.integerType == .pickTheRange, let secondNumberMin = parameters.secondNumberMin, let secondNumberMax = parameters.secondNumberMax {
//            operand2 = Int.random(in: secondNumberMin...secondNumberMax)
//        } else if parameters.integerType == .focusOnANumber, let otherNumberMin = parameters.otherNumberMin, let otherNumberMax = parameters.otherNumberMax {
//            operand2 = Int.random(in: otherNumberMin...otherNumberMax)
//        } else if parameters.integerSign == .positive {
//            operand2 = Int.random(in: minRange...maxRange)
//        } else {
//            operand2 = Bool.random() ? -Int.random(in: minRange...maxRange) : Int.random(in: minRange...maxRange)
//        }
        
//        let result: Int
//
//        switch parameters.operation {
//        case .addition:
//            result = operand1 + operand2
//        case .subtraction:
//            result = operand1 - operand2
//        }
        
        let operand1 = generateOperand1(minRange: minRange, maxRange: maxRange)
        let operand2 = generateOperand2(minRange: minRange, maxRange: maxRange, operand1: operand1)
        let result = generateResult(operand1: operand1, operand2: operand2)
        
        return Problem(number: number, operand1: operand1, operand2: operand2, operation: parameters.operation.rawValue, result: result)
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
        let operand1: Int
        
        if parameters.integerType == .pickTheRange, let firstNumberMin = parameters.firstNumberMin, let firstNumberMax = parameters.firstNumberMax {
            operand1 = Int.random(in: firstNumberMin...firstNumberMax)
        } else if parameters.integerType == .focusOnANumber, let focusNumber = parameters.focusNumber {
            operand1 = focusNumber
        } else if parameters.integerSign == .positive {
            operand1 = Int.random(in: minRange...maxRange)
        } else {
            operand1 = Bool.random() ? -Int.random(in: minRange...maxRange) : Int.random(in: minRange...maxRange)
        }
        
        return operand1
    }
    
    private func generateOperand2(minRange: Int, maxRange: Int, operand1: Int) -> Int {
        let operand2: Int
        
        if parameters.integerType == .doubles {
            operand2 = operand1
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
        }
        
        return result
    }
    
}

class ProblemSetParameters {
    
    static let shared = ProblemSetParameters()
    
    var numberType: NumberType = .integers
    var operation: Operation = .addition
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
