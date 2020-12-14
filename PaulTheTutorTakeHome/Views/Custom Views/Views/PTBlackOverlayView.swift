//
//  PTBlackOverlayView.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 12/13/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

class PTBlackOverlayView: UIView {
    
    // MARK: - Initialization Functions
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func showOverlay(on view: UIView) {
        UIView.animate(withDuration: 0.3) {
            self.isHidden = false
            self.alpha = 1
        }
    }
    
    @objc func hideOverlay() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0
            self.isHidden = true
        }
    }
    
    
    // MARK: - Configuration Functions
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Colors.blackOverlay
        isHidden = true
        alpha = 0
    }
    
}
