//
//  BinaryInteger+Ext.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 2/10/21.
//  Copyright © 2021 Dan Pham. All rights reserved.
//

import Foundation

// Referenced from https://www.hackingwithswift.com/example-code/language/how-to-split-an-integer-into-an-array-of-its-digits

extension BinaryInteger {
    var digits: [Int] {
        return String(describing: self).compactMap { Int(String($0)) }
    }
}
