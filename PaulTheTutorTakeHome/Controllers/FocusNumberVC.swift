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
    
}


// MARK: - Configuration Functions

extension FocusNumberVC {
    
    func configureUI() {
        configureViewController()
        configureQuestionLabel()
        configureFocusNumberLabel()
        configureFocusNumberTextfield()
        configureOtherNumberMinLabel()
        configureOtherNumberMinTextfield()
        configureOtherNumberMaxLabel()
        configureOtherNumberMaxTextfield()
        configureSubmitButton()
    }
    
    private func configureViewController() {
        view.backgroundColor = Colors.paulLightGreen
        view.addDismissKeyboardTapGesture()
        view.addSubviews(questionLabel, focusNumberLabel, focusNumberTextfield, otherNumberMinLabel, otherNumberMinTextfield, otherNumberMaxLabel, otherNumberMaxTextfield, submitButton)
    }
    
    private func configureQuestionLabel() {
        questionLabel.addFlexWidthSetHeightConstraints(to: view)
    }
    
    private func configureFocusNumberLabel() {
        focusNumberLabel.addFlexWidthSetHeightConstraints(to: view, aboveComponent: questionLabel, naturalHeight: true)
    }
    
    private func configureFocusNumberTextfield() {
        focusNumberTextfield.addFlexWidthSetHeightConstraints(to: view, aboveComponent: focusNumberLabel, smallTopPadding: true)
    }
    
    private func configureOtherNumberMinLabel() {
        otherNumberMinLabel.addFlexWidthSetHeightConstraints(to: view, aboveComponent: focusNumberTextfield, naturalHeight: true)
    }
    
    private func configureOtherNumberMinTextfield() {
        otherNumberMinTextfield.addFlexWidthSetHeightConstraints(to: view, aboveComponent: otherNumberMinLabel, smallTopPadding: true)
    }
    
    private func configureOtherNumberMaxLabel() {
        otherNumberMaxLabel.addFlexWidthSetHeightConstraints(to: view, aboveComponent: otherNumberMinTextfield, naturalHeight: true)
    }
    
    private func configureOtherNumberMaxTextfield() {
        otherNumberMaxTextfield.addFlexWidthSetHeightConstraints(to: view, aboveComponent: otherNumberMaxLabel, smallTopPadding: true)
    }
    
    private func configureSubmitButton() {
        submitButton.addTarget(self, action: #selector(submitNumberOfProblems), for: .touchUpInside)
        submitButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: otherNumberMaxTextfield)
    }
    
}
