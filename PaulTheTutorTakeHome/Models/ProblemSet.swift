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
        var count = 0
        
        while count <= parameters.numberOfProblems - 1 {
            if let newProblem = generateRandomProblem(number: count + 1, parameters: parameters) {
                if !newProblems.isEmpty {
                    if newProblem != newProblems[count - 1] {
                        newProblems.append(newProblem)
                        count += 1
                    }
                } else {
                    newProblems.append(newProblem)
                    count += 1
                }
            }
        }
        
        problems = newProblems
    }
    
    private func generateRandomProblem(number: Int, parameters: ProblemSetParameters) -> Problem? {
        guard let randomOperation = parameters.operation.randomElement(), let integerType = parameters.integerType.randomElement() else { return nil }
        
        let minRange = calculateMinRange(integerType: integerType)
        let maxRange = calculateMaxRange(integerType: integerType)
        var operand1 = generateOperand1(minRange: minRange, maxRange: maxRange)
        var operand2 = generateOperand2(minRange: minRange, maxRange: maxRange, operand1: operand1, operation: randomOperation, integerType: integerType)
        
        if randomOperation == .subtraction && (parameters.integerSign == .positive || parameters.integerType == [.doubles]) {
            if operand1 < operand2 {
                swap(&operand1, &operand2)
            }
            
            let result = operand1 - operand2
            return Problem(number: number, operand1: operand1, operand2: operand2, operation: randomOperation.rawValue, integerResult: result)
        } else if randomOperation == .division && parameters.divisionType == .even {
            swap(&operand1, &operand2)
            let result = operand1 / operand2
            return Problem(number: number, operand1: operand1, operand2: operand2, operation: randomOperation.rawValue, integerResult: result)
        } else if randomOperation == .division && parameters.divisionType == .remainders {
            swap(&operand1, &operand2)
            let quotient = operand1 / operand2
            let remainder = operand1 % operand2
            return Problem(number: number, operand1: operand1, operand2: operand2, operation: randomOperation.rawValue, quotient: quotient, remainder: remainder)
        } else if randomOperation == .division && parameters.divisionType == .decimals {
            swap(&operand1, &operand2)
            let result = (Double(operand1) / Double(operand2)).round(toPlaces: 2)
            return Problem(number: number, operand1: operand1, operand2: operand2, operation: randomOperation.rawValue, decimalResult: result)
        } else {
            let result = generateResult(operand1: operand1, operand2: operand2, operation: randomOperation)
            return Problem(number: number, operand1: operand1, operand2: operand2, operation: randomOperation.rawValue, integerResult: result)
        }
    }
    
    private func calculateMinRange(integerType: ProblemSetParameters.IntegerType) -> Int {
        let minRange: Int
        switch integerType {
        case .doubles:
            minRange = 1
        case .pairsOfTen:
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
    
    private func calculateMaxRange(integerType: ProblemSetParameters.IntegerType) -> Int {
        let maxRange: Int
        switch integerType {
        case .doubles:
            maxRange = 9
        case .pairsOfTen:
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
        
        if parameters.integerType == [.pickTheRange], var firstNumberMin = parameters.firstNumberMin, var firstNumberMax = parameters.firstNumberMax {
            if firstNumberMin > firstNumberMax {
                swap(&firstNumberMin, &firstNumberMax)
            }
            
            operand1 = Int.random(in: firstNumberMin...firstNumberMax)
        } else if parameters.integerType == [.focusOnANumber], let focusNumber = parameters.focusNumber {
            operand1 = focusNumber
        } else if parameters.integerSign == .positive {
            operand1 = Int.random(in: minRange...maxRange)
        } else {
            operand1 = Bool.random() ? -Int.random(in: minRange...maxRange) : Int.random(in: minRange...maxRange)
        }
        
        if parameters.divisionType != nil && operand1 == 0 { return 1 }
        
        return operand1
    }
    
    private func generateOperand2(minRange: Int, maxRange: Int, operand1: Int, operation: ProblemSetParameters.Operation, integerType: ProblemSetParameters.IntegerType) -> Int {
        let operand2: Int
        
        if parameters.subtractionType == .noBorrowing && (parameters.integerType != [.pickTheRange] || parameters.integerType == [.focusOnANumber]) {
            var operand2DigitString = ""
            let digits = operand1.digits
            
            for digit in digits {
                let randomDigit = Int.random(in: 0...digit)
                operand2DigitString.append("\(randomDigit)")
            }
            
            operand2 = Int(operand2DigitString) ?? Int.random(in: minRange...maxRange)
        } else if integerType == .doubles {
            if operation == .subtraction || operation == .division {
                operand2 = operand1 * 2
            } else {
                operand2 = operand1
            }
        } else if integerType == .pairsOfTen {
            if operation == .subtraction {
                operand2 = 10
            } else {
                operand2 = 10 - operand1
            }
        } else if parameters.divisionType == .even {
            operand2 = operand1 * Int.random(in: minRange...maxRange)
        } else if parameters.integerType == [.pickTheRange], var secondNumberMin = parameters.secondNumberMin, var secondNumberMax = parameters.secondNumberMax {
            if secondNumberMin > secondNumberMax {
                swap(&secondNumberMin, &secondNumberMax)
            }
            
//            if parameters.subtractionType == .noBorrowing {
//                var operand2DigitString = ""
//                let digits = operand1.digits
//
//                for digit in digits {
//                    var minDigit = secondNumberMin > digit ? secondNumberMin : 0
//                    var maxDigit = secondNumberMax < digit ? secondNumberMax : digit
//
//                    if minDigit > maxDigit {
//                        swap(&minDigit, &maxDigit)
//                    }
//
//                    let randomDigit = Int.random(in: minDigit...maxDigit)
//                    operand2DigitString.append("\(randomDigit)")
//                }
//
//                operand2 = Int(operand2DigitString) ?? Int.random(in: secondNumberMin...secondNumberMax)
//            } else {
                operand2 = Int.random(in: secondNumberMin...secondNumberMax)
//            }
        } else if parameters.integerType == [.focusOnANumber], var otherNumberMin = parameters.otherNumberMin, var otherNumberMax = parameters.otherNumberMax {
            if otherNumberMin > otherNumberMax {
                swap(&otherNumberMin, &otherNumberMax)
            }
            
//            if parameters.subtractionType == .noBorrowing {
//                var operand2DigitString = ""
//                let digits = operand1.digits
//
//                for digit in digits {
//                    var minDigit = otherNumberMin > digit ? otherNumberMin : 0
//                    var maxDigit = otherNumberMax < digit ? otherNumberMax : digit
//
//                    if minDigit > maxDigit {
//                        swap(&minDigit, &maxDigit)
//                    }
//
//                    let randomDigit = Int.random(in: minDigit...maxDigit)
//                    operand2DigitString.append("\(randomDigit)")
//                }
//
//                operand2 = Int(operand2DigitString) ?? Int.random(in: minRange...maxRange)
//            } else {
                operand2 = Int.random(in: otherNumberMin...otherNumberMax)
//            }
        } else if parameters.integerSign == .positive {
            operand2 = Int.random(in: minRange...maxRange)
        } else {
            operand2 = Bool.random() ? -Int.random(in: minRange...maxRange) : Int.random(in: minRange...maxRange)
        }
        
        return operand2
    }
    
    private func generateResult(operand1: Int, operand2: Int, operation: ProblemSetParameters.Operation) -> Int {
        let result: Int
        
        switch operation {
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
    var operation: [Operation] = [.addition]
    var subtractionType: SubtractionType?
    var divisionType: DivisionType?
    var integerType: [IntegerType] = [.oneDigit]
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
    
    enum SubtractionType {
        case borrowing
        case noBorrowing
    }
    
    enum DivisionType {
        case even
        case remainders
        case decimals
    }
    
    enum IntegerType {
        case doubles
        case pairsOfTen
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
