//
//  PTTextField.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/10/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

class PTTextField: UITextField {
    
    // MARK: - Initialization Functions
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Configuration Functions
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .black
        tintColor = .black
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title1)
        adjustsFontSizeToFitWidth = true
        
        backgroundColor = .white
        keyboardType = .numberPad
        autocorrectionType = .no
    }
    
}
