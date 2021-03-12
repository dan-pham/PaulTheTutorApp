//
//  Date+Ext.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 3/11/21.
//  Copyright © 2021 Dan Pham. All rights reserved.
//

import Foundation

extension Date {
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
}
