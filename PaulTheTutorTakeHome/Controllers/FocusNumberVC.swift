//
//  FocusNumberVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 12/13/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

class FocusNumberVC: UIViewController {
    
    let questionLabel = PTTitleLabel(textAlignment: .left, fontSize: 20)
    
    let focusNumberLabel = PTTitleLabel(textAlignment: .left, fontSize: 20)
    let focusNumberTextfield = PTTextField(frame: .zero)
    
    let otherNumberMinLabel = PTTitleLabel(textAlignment: .left, fontSize: 20)
    let otherNumberMinTextfield = PTTextField(frame: .zero)
    
    let otherNumberMaxLabel = PTTitleLabel(textAlignment: .left, fontSize: 20)
    let otherNumberMaxTextfield = PTTextField(frame: .zero)
    
    let submitButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "submit")
    let padding = Padding.standard
    let smallPadding = Padding.small
    
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
        questionLabel.text = "What number do you want to focus on?"
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            questionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            questionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            questionLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureFocusNumberLabel() {
        focusNumberLabel.text = "Focus on number"
        
        NSLayoutConstraint.activate([
            focusNumberLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: padding),
            focusNumberLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            focusNumberLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding)
        ])
    }
    
    private func configureFocusNumberTextfield() {
        NSLayoutConstraint.activate([
            focusNumberTextfield.topAnchor.constraint(equalTo: focusNumberLabel.bottomAnchor, constant: smallPadding),
            focusNumberTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            focusNumberTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            focusNumberTextfield.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureOtherNumberMinLabel() {
        otherNumberMinLabel.text = "Other number's min"
        
        NSLayoutConstraint.activate([
            otherNumberMinLabel.topAnchor.constraint(equalTo: focusNumberTextfield.bottomAnchor, constant: padding),
            otherNumberMinLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            otherNumberMinLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding)
        ])
    }
    
    private func configureOtherNumberMinTextfield() {
        NSLayoutConstraint.activate([
            otherNumberMinTextfield.topAnchor.constraint(equalTo: otherNumberMinLabel.bottomAnchor, constant: smallPadding),
            otherNumberMinTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            otherNumberMinTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            otherNumberMinTextfield.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureOtherNumberMaxLabel() {
        otherNumberMaxLabel.text = "Other number's max"
        
        NSLayoutConstraint.activate([
            otherNumberMaxLabel.topAnchor.constraint(equalTo: otherNumberMinTextfield.bottomAnchor, constant: padding),
            otherNumberMaxLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            otherNumberMaxLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding)
        ])
    }
    
    private func configureOtherNumberMaxTextfield() {
        NSLayoutConstraint.activate([
            otherNumberMaxTextfield.topAnchor.constraint(equalTo: otherNumberMaxLabel.bottomAnchor, constant: smallPadding),
            otherNumberMaxTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            otherNumberMaxTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            otherNumberMaxTextfield.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureSubmitButton() {
        submitButton.addTarget(self, action: #selector(submitNumberOfProblems), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: otherNumberMaxTextfield.bottomAnchor, constant: padding),
            submitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            submitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
