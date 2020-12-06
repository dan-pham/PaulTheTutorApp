//
//  PTTitleLabel.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/10/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

class PTTitleLabel: UILabel {
    
    // MARK: - Initialization Functions
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    
    // MARK: - Configuration Functions
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .label
        lineBreakMode = .byTruncatingTail
        
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
    }
    
}
