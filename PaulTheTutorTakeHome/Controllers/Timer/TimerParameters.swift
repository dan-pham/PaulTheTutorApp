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
    var testSections: [TestSection] = []
    
    private init() { }
    
    enum TestType {
        case act
        case sat
    }

    enum TestSection {
        case english
        case math
        case break1
        case reading
        case science
        case break2
        case essay
    }
    
}
