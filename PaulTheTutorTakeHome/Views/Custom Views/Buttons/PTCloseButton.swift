//
//  PTCloseButton.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 12/13/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

class PTCloseButton: UIView {
    
    let imageView = UIImageView()
    let padding = Padding.small
    
    // MARK: - Initialization Functions
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, tintColor: UIColor) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        imageView.tintColor = tintColor
    }
    
    
    // MARK: - Configuration Functions
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "xmark")!
        imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8)
        ])
    }
    
}
