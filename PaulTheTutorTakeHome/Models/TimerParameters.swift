//
//  TimerParameters.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 1/5/21.
//  Copyright © 2021 Dan Pham. All rights reserved.
//

import Foundation

class TimerParameters {
    
    static let shared = TimerParameters()
    
    var testType: TestType = .act
    var isExtended = false
    var tests: [Test] = []
    
    private init() { }
    
    enum TestType: String {
        case act = "ACT"
        case sat = "SAT"
    }
    
}

struct Tests {
    static let english = Test(title: "Section 1 [English, 75 questions] - 45 minutes", shortTitle: "English - 45 minutes", durationInMinutes: 45, orderNumber: 0)
    static let math = Test(title: "Section 2 [Math, 60 questions] - 60 minutes", shortTitle: "Math - 60 minutes", durationInMinutes: 60, orderNumber: 1)
    static let testBreak1 = Test(title: "Break - 5 minutes", shortTitle: "Break - 5 minutes", durationInMinutes: 5, orderNumber: 2)
    static let reading = Test(title: "Section 3 [Reading, 40 questions] - 35 minutes", shortTitle: "Reading - 35 minutes", durationInMinutes: 35, orderNumber: 3)
    static let science = Test(title: "Section 4 [Science, 40 questions] - 35 minutes", shortTitle: "Science - 35 minutes", durationInMinutes: 35, orderNumber: 4)
    static let testBreak2 = Test(title: "Break 2 (optional) - 5 minutes", shortTitle: "Break - 5 minutes", durationInMinutes: 5, orderNumber: 5)
    static let essay = Test(title: "Essay (optional) - 30 minutes", shortTitle: "Essay - 30 minutes", durationInMinutes: 30, orderNumber: 6)
}

enum TimeRemainingWarnings: String {
    case tenMinutes = "10 minutes remaining"
    case fiveMinutes = "5 minutes remaining"
    case oneMinute = "1 minute remaining"
    case zeroMinutes = "Time's up for this section!"
    case finalTest = "Pencils down!"
}

class Test: Equatable {
    let title: String
    let shortTitle: String
    let duration: Int
    let secondsInMinute = 60
    let orderNumber: Int
    
    init(title: String, shortTitle: String, durationInMinutes: Int, orderNumber: Int) {
        self.title = title
        self.shortTitle = shortTitle
        self.duration = durationInMinutes * secondsInMinute
        self.orderNumber = orderNumber
    }
    
    static func == (lhs: Test, rhs: Test) -> Bool {
        lhs.orderNumber == rhs.orderNumber
    }
}

enum TimerNotification: String {
    case action = "timerAction"
    case category = "timerCategory"
}

class CurrentTestSession {
    private let testTypeKey            = "testType"
    private let testOrderNumbersKey    = "testOrderNumbers"
    private let firstTestEndTimeKey    = "firstTestEndTime"
    private let secondTestEndTimeKey   = "secondTestEndTime"
    private let thirdTestEndTimeKey    = "thirdTestEndTime"
    private let fourthTestEndTimeKey   = "fourthTestEndTime"
    private let fifthTestEndTimeKey    = "fifthTestEndTime"
    private let sixthTestEndTimeKey    = "sixthTestEndTime"
    private let seventhTestEndTimeKey  = "seventhTestEndTime"
    
    
    var testType: String {
        didSet {
            UserDefaults.standard.setValue(testType, forKey: testTypeKey)
//            print("Saving testType: \(testType)")
        }
    }
    
    var testOrderNumbers: [Int] {
        didSet {
            UserDefaults.standard.setValue(testOrderNumbers, forKey: testOrderNumbersKey)
//            print("Saving testOrderNumbers: \(testOrderNumbers)")
        }
    }
    
    var firstTestEndTime: String {
        didSet {
            UserDefaults.standard.setValue(firstTestEndTime, forKey: firstTestEndTimeKey)
//            print("firstTestEndTime: \(firstTestEndTime)")
        }
    }
    
    var secondTestEndTime: String {
        didSet {
            UserDefaults.standard.setValue(secondTestEndTime, forKey: secondTestEndTimeKey)
//            print("secondTestEndTime: \(secondTestEndTime)")
        }
    }
    
    var thirdTestEndTime: String {
        didSet {
            UserDefaults.standard.setValue(thirdTestEndTime, forKey: thirdTestEndTimeKey)
//            print("thirdTestEndTime: \(thirdTestEndTime)")
        }
    }
    
    var fourthTestEndTime: String {
        didSet {
            UserDefaults.standard.setValue(fourthTestEndTime, forKey: fourthTestEndTimeKey)
//            print("fourthTestEndTime: \(fourthTestEndTime)")
        }
    }
    
    var fifthTestEndTime: String {
        didSet {
            UserDefaults.standard.setValue(fifthTestEndTime, forKey: fifthTestEndTimeKey)
//            print("fifthTestEndTime: \(fifthTestEndTime)")
        }
    }
    
    var sixthTestEndTime: String {
        didSet {
            UserDefaults.standard.setValue(sixthTestEndTime, forKey: sixthTestEndTimeKey)
//            print("sixthTestEndTime: \(sixthTestEndTime)")
        }
    }
    
    var seventhTestEndTime: String {
        didSet {
            UserDefaults.standard.setValue(seventhTestEndTime, forKey: seventhTestEndTimeKey)
//            print("seventhTestEndTime: \(seventhTestEndTime)")
        }
    }
    
    func clearCurrentTestSession() {
        UserDefaults.standard.setValue("", forKey: testTypeKey)
        UserDefaults.standard.setValue([], forKey: testOrderNumbersKey)
        UserDefaults.standard.setValue("", forKey: firstTestEndTimeKey)
        UserDefaults.standard.setValue("", forKey: secondTestEndTimeKey)
        UserDefaults.standard.setValue("", forKey: thirdTestEndTimeKey)
        UserDefaults.standard.setValue("", forKey: fourthTestEndTimeKey)
        UserDefaults.standard.setValue("", forKey: fifthTestEndTimeKey)
        UserDefaults.standard.setValue("", forKey: sixthTestEndTimeKey)
        UserDefaults.standard.setValue("", forKey: seventhTestEndTimeKey)
    }
    
    
    init() {
        testType            = UserDefaults.standard.string(forKey: testTypeKey) ?? ""
        testOrderNumbers    = UserDefaults.standard.array(forKey: testOrderNumbersKey) as? [Int] ?? []
        firstTestEndTime    = UserDefaults.standard.string(forKey: firstTestEndTimeKey) ?? ""
        secondTestEndTime   = UserDefaults.standard.string(forKey: secondTestEndTimeKey) ?? ""
        thirdTestEndTime    = UserDefaults.standard.string(forKey: thirdTestEndTimeKey) ?? ""
        fourthTestEndTime   = UserDefaults.standard.string(forKey: fourthTestEndTimeKey) ?? ""
        fifthTestEndTime    = UserDefaults.standard.string(forKey: fifthTestEndTimeKey) ?? ""
        sixthTestEndTime    = UserDefaults.standard.string(forKey: sixthTestEndTimeKey) ?? ""
        seventhTestEndTime  = UserDefaults.standard.string(forKey: seventhTestEndTimeKey) ?? ""
    }
}
