//
//  String+Ext.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 3/11/21.
//  Copyright © 2021 Dan Pham. All rights reserved.
//

import Foundation

extension String {
    
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
        return dateFormatter.date(from: self)
    }
    
}
