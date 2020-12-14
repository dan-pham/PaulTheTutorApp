//
//  Constants.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/10/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit
import Lottie


enum Animations {
    static let plusAnimation = Animation.named("plus")
    static let minusAnimation = Animation.named("minus")
    static let smileAnimation = Animation.named("smile")
}


enum Colors {
    static let paulLightGreen = UIColor.rgb(red: 220, green: 233, blue: 213)
    static let paulDarkGreen = UIColor.rgb(red: 19, green: 73, blue: 29)
    
    static let blackOverlay = UIColor.black.withAlphaComponent(0.7)
}


enum Images {
    static let logo = UIImage(named: "logo")
}


enum Padding {
    static let small: CGFloat = 8
    static let standard: CGFloat = 24
    static let large: CGFloat = 40
}


enum SFSymbols {
    static let ellipsis = UIImage(systemName: "ellipsis")
    static let chevronRight = UIImage(systemName: "chevron.right")
    static let plus = UIImage(systemName: "plus")
    static let minus = UIImage(systemName: "minus")
}
