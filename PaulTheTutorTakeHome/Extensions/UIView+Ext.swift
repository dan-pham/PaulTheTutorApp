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
    
    // Referenced from https://stackoverflow.com/questions/14148276/toolbar-with-previous-and-next-for-keyboard-inputaccessoryview
    func addInputAccessoryForTextFields(textFields: [UITextField], dismissable: Bool = true, previousNextable: Bool = false, isHorizontal: Bool = false) {
        for (index, textField) in textFields.enumerated() {
            let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))
            toolbar.sizeToFit()
            
            var items = [UIBarButtonItem]()
            if previousNextable {
                let previousButton = UIBarButtonItem(image: UIImage(systemName: "chevron.\(isHorizontal ? "left" : "up")"), style: .plain, target: nil, action: nil)
                previousButton.width = 30
                if textField == textFields.first {
                    previousButton.isEnabled = false
                } else {
                    previousButton.target = textFields[index - 1]
                    previousButton.action = #selector(UITextField.becomeFirstResponder)
                }
                
                let nextButton = UIBarButtonItem(image: UIImage(systemName: "chevron.\(isHorizontal ? "right" : "down")"), style: .plain, target: nil, action: nil)
                nextButton.width = 30
                if textField == textFields.last {
                    nextButton.isEnabled = false
                } else {
                    nextButton.target = textFields[index + 1]
                    nextButton.action = #selector(UITextField.becomeFirstResponder)
                }
                items.append(contentsOf: [previousButton, nextButton])
            }
            
            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(UIView.endEditing))
            items.append(contentsOf: [spacer, doneButton])
            
            for item in items {
                item.tintColor = Colors.paulDarkGreen
            }
            
            toolbar.setItems(items, animated: false)
            textField.inputAccessoryView = toolbar
        }
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
        let padding = Padding.standard
        let topPadding = smallTopPadding ? Padding.small : Padding.standard
        let isTop = aboveComponent != nil ? false : true
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: isScrollViewTop ? superview.topAnchor : isTop ? superview.safeAreaLayoutGuide.topAnchor : aboveComponent!.bottomAnchor, constant: topPadding),
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
