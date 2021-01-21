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
    
    enum TestType {
        case act
        case sat
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
