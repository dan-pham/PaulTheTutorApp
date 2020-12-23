//
//  Double+Ext.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 12/22/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import Foundation

extension Double {
    
    func round(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
}
