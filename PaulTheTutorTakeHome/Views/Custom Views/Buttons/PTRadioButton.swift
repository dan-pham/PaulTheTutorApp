//
//  PTRadioButton.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 1/5/21.
//  Copyright © 2021 Dan Pham. All rights reserved.
//

import DLRadioButton
import UIKit

class PTRadioButton: DLRadioButton {
    
    // MARK: - Initialization Functions
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, isIconSquare: Bool) {
        self.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.isIconSquare = isIconSquare
        
        if isIconSquare {
            icon = UIImage(systemName: "square")!.withTintColor(Colors.paulDarkGreen, renderingMode: .alwaysOriginal)
            iconSelected = UIImage(systemName: "checkmark.square")!.withTintColor(Colors.paulDarkGreen, renderingMode: .alwaysOriginal)
        }
    }
    
    
    // MARK: - Configuration Functions
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(Colors.paulDarkGreen, for: .normal)
        contentHorizontalAlignment = .left
        titleLabel?.numberOfLines = 2
    }
    
}
