//
//  Constants.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/10/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit
import Lottie

enum SFSymbols {
    static let ellipsis = UIImage(systemName: "ellipsis")
    static let chevronRight = UIImage(systemName: "chevron.right")
    static let plus = UIImage(systemName: "plus")
    static let minus = UIImage(systemName: "minus")
}

enum Images {
    static let logo = UIImage(named: "logo")
}

enum Animations {
    static let plusAnimation = Animation.named("plus")
    static let minusAnimation = Animation.named("minus")
    static let smileAnimation = Animation.named("smile")
}

enum Colors {
    static let paulLightGreen = UIColor.rgb(red: 220, green: 233, blue: 213)
    static let paulDarkGreen = UIColor.rgb(red: 19, green: 73, blue: 29)
    
    static let blackOverlay = UIColor.black.withAlphaComponent(0.8)
}
