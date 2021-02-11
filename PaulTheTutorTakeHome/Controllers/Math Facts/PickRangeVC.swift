//
//  PickRangeVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 12/13/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

class PickRangeVC: UIViewController {
    
    let questionLabel = PTTitleLabel(textAlignment: .left, fontSize: 20, text: "What range do you want to focus on?")
    let scrollView = PTScrollView(heightConstraint: 550)
    
    let firstNumberMinLabel = PTTitleLabel(textAlignment: .left, fontSize: 20, text: "Min for 1st Number")
    let firstNumberMinTextfield = PTTextField(frame: .zero)
    let firstNumberMaxLabel = PTTitleLabel(textAlignment: .left, fontSize: 20, text: "Max for 1st Number")
    let firstNumberMaxTextfield = PTTextField(frame: .zero)
    let secondNumberMinLabel = PTTitleLabel(textAlignment: .left, fontSize: 20, text: "Other number's min")
    let secondNumberMinTextfield = PTTextField(frame: .zero)
    let secondNumberMaxLabel = PTTitleLabel(textAlignment: .left, fontSize: 20, text: "Other number's max")
    let secondNumberMaxTextfield = PTTextField(frame: .zero)
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
        guard let firstNumberMinText = firstNumberMinTextfield.text, !firstNumberMinText.isEmpty, let firstNumberMin = Int(firstNumberMinText),
              let firstNumberMaxText = firstNumberMaxTextfield.text, !firstNumberMaxText.isEmpty, let firstNumberMax = Int(firstNumberMaxText),
              let secondNumberMinText = secondNumberMinTextfield.text, !secondNumberMinText.isEmpty, let secondNumberMin = Int(secondNumberMinText),
              let secondNumberMaxText = secondNumberMaxTextfield.text, !secondNumberMaxText.isEmpty, let secondNumberMax = Int(secondNumberMaxText)
        else {
            print("Alert: Please enter a whole number")
            return
        }
        
        view.endEditing(true)
        
        parameters.firstNumberMin = firstNumberMin
        parameters.firstNumberMax = firstNumberMax
        parameters.secondNumberMin = secondNumberMin
        parameters.secondNumberMax = secondNumberMax
        
        navigateToNextVC()
    }
    
    private func navigateToNextVC() {
//        guard let firstNumberMin = parameters.firstNumberMin, let firstNumberMax = parameters.firstNumberMax,
//              let secondNumberMin = parameters.secondNumberMin, let secondNumberMax = parameters.secondNumberMax else { return }
//
//        if parameters.operation.contains(.subtraction) && (firstNumberMin.digits.count > 1 || firstNumberMax.digits.count > 1 || secondNumberMin.digits.count > 1 || secondNumberMax.digits.count > 1) {
//            navigationController?.pushViewController(TypeOfSubtractionVC(), animated: true)
//        } else {
            let vc = NumberOfProblemsVC()
            navigationController?.pushViewController(vc, animated: true)
//        }
    }
    
    private func configureUI() {
        view.backgroundColor = Colors.paulLightGreen
        view.addDismissKeyboardTapGesture()
        view.addInputAccessoryForTextFields(textFields: [firstNumberMinTextfield, firstNumberMaxTextfield, secondNumberMinTextfield, secondNumberMaxTextfield], dismissable: true, previousNextable: true)
        view.addSubviews(questionLabel, scrollView)
        
        questionLabel.addFlexWidthSetHeightConstraints(to: view)
        
        scrollView.addSubviews(firstNumberMinLabel, firstNumberMinTextfield, firstNumberMaxLabel, firstNumberMaxTextfield, secondNumberMinLabel, secondNumberMinTextfield, secondNumberMaxLabel, secondNumberMaxTextfield, submitButton)
        scrollView.addScrollViewConstraints(to: view, aboveComponent: questionLabel)
        
        firstNumberMinLabel.addFlexWidthSetHeightConstraints(to: scrollView, naturalHeight: true, isScrollViewTop: true)
        firstNumberMinTextfield.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: firstNumberMinLabel, smallTopPadding: true)
        
        firstNumberMaxLabel.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: firstNumberMinTextfield, naturalHeight: true)
        firstNumberMaxTextfield.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: firstNumberMaxLabel, smallTopPadding: true)
        
        secondNumberMinLabel.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: firstNumberMaxTextfield, naturalHeight: true)
        secondNumberMinTextfield.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: secondNumberMinLabel, smallTopPadding: true)
        
        secondNumberMaxLabel.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: secondNumberMinTextfield, naturalHeight: true)
        secondNumberMaxTextfield.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: secondNumberMaxLabel, smallTopPadding: true)
        
        submitButton.addTarget(self, action: #selector(submitNumberOfProblems), for: .touchUpInside)
        submitButton.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: secondNumberMaxTextfield)
    }
    
}
