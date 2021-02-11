//
//  FocusNumberVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 12/13/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

class FocusNumberVC: UIViewController {
    
    let questionLabel = PTTitleLabel(textAlignment: .left, fontSize: 20, text: "What number do you want to focus on?")
    let scrollView = PTScrollView(heightConstraint: 550)
    
    let focusNumberLabel = PTTitleLabel(textAlignment: .left, fontSize: 20, text: "Focus on number")
    let focusNumberTextfield = PTTextField(frame: .zero)
    
    let otherNumberMinLabel = PTTitleLabel(textAlignment: .left, fontSize: 20, text: "Other number's min")
    let otherNumberMinTextfield = PTTextField(frame: .zero)
    
    let otherNumberMaxLabel = PTTitleLabel(textAlignment: .left, fontSize: 20, text: "Other number's max")
    let otherNumberMaxTextfield = PTTextField(frame: .zero)
    
    let submitButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "submit")
    
    let parameters = ProblemSetParameters.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        registerForKeyboardNotifications()
    }
    
    private func registerForKeyboardNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc private func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    @objc func submitNumberOfProblems() {
        guard let focusNumberText = focusNumberTextfield.text, !focusNumberText.isEmpty, let focusNumber = Int(focusNumberText),
              let otherNumberMinText = otherNumberMinTextfield.text, !otherNumberMinText.isEmpty, let otherNumberMin = Int(otherNumberMinText),
              let otherNumberMaxText = otherNumberMaxTextfield.text, !otherNumberMaxText.isEmpty, let otherNumberMax = Int(otherNumberMaxText)
        else {
            print("Alert: Please enter a whole number")
            return
        }
        
        view.endEditing(true)
        
        parameters.focusNumber = focusNumber
        parameters.otherNumberMin = otherNumberMin
        parameters.otherNumberMax = otherNumberMax
        
        navigateToNextVC()
    }
    
    private func navigateToNextVC() {
        let vc = NumberOfProblemsVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = Colors.paulLightGreen
        view.addDismissKeyboardTapGesture()
        view.addInputAccessoryForTextFields(textFields: [focusNumberTextfield, otherNumberMinTextfield, otherNumberMaxTextfield], dismissable: true, previousNextable: true)
        view.addSubviews(questionLabel, scrollView)
        
        questionLabel.addFlexWidthSetHeightConstraints(to: view)
        
        scrollView.addSubviews(focusNumberLabel, focusNumberTextfield, otherNumberMinLabel, otherNumberMinTextfield, otherNumberMaxLabel, otherNumberMaxTextfield, submitButton)
        scrollView.addScrollViewConstraints(to: view, aboveComponent: questionLabel)
        
        focusNumberLabel.addFlexWidthSetHeightConstraints(to: scrollView, naturalHeight: true, isScrollViewTop: true)
        focusNumberTextfield.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: focusNumberLabel, smallTopPadding: true)
        
        otherNumberMinLabel.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: focusNumberTextfield, naturalHeight: true)
        otherNumberMinTextfield.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: otherNumberMinLabel, smallTopPadding: true)
        
        otherNumberMaxLabel.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: otherNumberMinTextfield, naturalHeight: true)
        otherNumberMaxTextfield.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: otherNumberMaxLabel, smallTopPadding: true)
        
        submitButton.addTarget(self, action: #selector(submitNumberOfProblems), for: .touchUpInside)
        submitButton.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: otherNumberMaxTextfield)
    }
    
}
