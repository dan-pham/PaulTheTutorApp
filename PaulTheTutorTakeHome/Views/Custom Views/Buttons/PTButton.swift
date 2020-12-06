//
//  PTButton.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/10/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

class PTButton: UIButton {
    
    // MARK: - Initialization Functions
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(titleColor: UIColor, backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        setTitleColor(titleColor, for: .normal)
        setTitleColor(titleColor.withAlphaComponent(0.7), for: .highlighted)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    override var isHighlighted: Bool {
        didSet {
            if backgroundColor != .clear {
                backgroundColor = backgroundColor?.withAlphaComponent(isHighlighted ? 0.7 : 1)
            }
        }
    }
    
    
    // MARK: - Configuration Functions
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
    }
    
}
