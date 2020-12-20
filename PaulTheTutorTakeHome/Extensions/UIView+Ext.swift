//
//  UIView+Ext.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/10/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    func addDismissKeyboardTapGesture() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing)))
    }
    
    func pinToEdges(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
    
    func addFlexWidthSetHeightConstraints(to superview: UIView, aboveComponent: UIView? = nil, naturalHeight: Bool = false, smallTopPadding: Bool = false, isScrollViewTop: Bool = false) {
        let padding = smallTopPadding ? Padding.small : Padding.standard
        let isTop = aboveComponent != nil ? false : true
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: isScrollViewTop ? superview.topAnchor : isTop ? superview.safeAreaLayoutGuide.topAnchor : aboveComponent!.bottomAnchor, constant: padding),
            leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: -padding)
        ])
        
        if !naturalHeight {
            NSLayoutConstraint.activate([heightAnchor.constraint(equalToConstant: 50)])
        }
    }
    
    func addScrollViewConstraints(to superview: UIView, aboveComponent: UIView? = nil, belowComponent: UIView? = nil) {
        let padding = Padding.standard
        let isTop = aboveComponent != nil ? false : true
        let isBottom = belowComponent != nil ? false : true
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: isTop ? superview.safeAreaLayoutGuide.topAnchor : aboveComponent!.bottomAnchor),
            leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor),
            bottomAnchor.constraint(equalTo: isBottom ? superview.safeAreaLayoutGuide.bottomAnchor : belowComponent!.topAnchor, constant: -padding)
        ])
    }
    
}
