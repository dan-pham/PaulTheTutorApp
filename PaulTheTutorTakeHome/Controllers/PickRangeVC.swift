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
        let vc = NumberOfProblemsVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


// MARK: - Configuration Functions

extension PickRangeVC {
    
    func configureUI() {
        configureViewController()
        configureQuestionLabel()
        configureFirstNumberMinLabel()
        configureFirstNumberMinTextfield()
        configureFirstNumberMaxLabel()
        configureFirstNumberMaxTextfield()
        configureSecondNumberMinLabel()
        configureSecondNumberMinTextfield()
        configureSecondNumberMaxLabel()
        configureSecondNumberMaxTextfield()
        configureSubmitButton()
    }
    
    private func configureViewController() {
        view.backgroundColor = Colors.paulLightGreen
        view.addDismissKeyboardTapGesture()
        view.addSubviews(questionLabel, firstNumberMinLabel, firstNumberMinTextfield, firstNumberMaxLabel, firstNumberMaxTextfield, secondNumberMinLabel, secondNumberMinTextfield, secondNumberMaxLabel, secondNumberMaxTextfield, submitButton)
    }
    
    private func configureQuestionLabel() {
        questionLabel.addFlexWidthSetHeightConstraints(to: view)
    }
    
    private func configureFirstNumberMinLabel() {
        firstNumberMinLabel.addFlexWidthSetHeightConstraints(to: view, aboveComponent: questionLabel, naturalHeight: true)
    }
    
    private func configureFirstNumberMinTextfield() {
        firstNumberMinTextfield.addFlexWidthSetHeightConstraints(to: view, aboveComponent: firstNumberMinLabel, smallTopPadding: true)
    }
    
    private func configureFirstNumberMaxLabel() {
        firstNumberMaxLabel.addFlexWidthSetHeightConstraints(to: view, aboveComponent: firstNumberMinTextfield, naturalHeight: true)
    }
    
    private func configureFirstNumberMaxTextfield() {
        firstNumberMaxTextfield.addFlexWidthSetHeightConstraints(to: view, aboveComponent: firstNumberMaxLabel, smallTopPadding: true)
    }
    
    private func configureSecondNumberMinLabel() {
        secondNumberMinLabel.addFlexWidthSetHeightConstraints(to: view, aboveComponent: firstNumberMaxTextfield, naturalHeight: true)
    }
    
    private func configureSecondNumberMinTextfield() {
        secondNumberMinTextfield.addFlexWidthSetHeightConstraints(to: view, aboveComponent: secondNumberMinLabel, smallTopPadding: true)
    }
    
    private func configureSecondNumberMaxLabel() {
        secondNumberMaxLabel.addFlexWidthSetHeightConstraints(to: view, aboveComponent: secondNumberMinTextfield, naturalHeight: true)
    }
    
    private func configureSecondNumberMaxTextfield() {
        secondNumberMaxTextfield.addFlexWidthSetHeightConstraints(to: view, aboveComponent: secondNumberMaxLabel, smallTopPadding: true)
    }
    
    private func configureSubmitButton() {
        submitButton.addTarget(self, action: #selector(submitNumberOfProblems), for: .touchUpInside)
        submitButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: secondNumberMaxTextfield)
    }
    
}
