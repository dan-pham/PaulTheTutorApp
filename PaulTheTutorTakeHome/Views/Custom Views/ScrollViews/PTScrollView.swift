//
//  PTScrollView.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/11/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

class PTScrollView: UIScrollView {
    
    // MARK: - Variables and Constants
    
    let contentView = UIView()
    var heightConstraint: CGFloat = 0
    
    
    // MARK: - Initialization Functions
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(heightConstraint: CGFloat) {
        self.init(frame: .zero)
        self.heightConstraint = heightConstraint
        
        configureContentView()
    }
    
    
    // MARK: - Configuration Functions
    
    private func configure() {
        addSubview(contentView)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureContentView() {
        contentView.pinToEdges(of: self)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: heightConstraint)
        ])
    }
    
}
