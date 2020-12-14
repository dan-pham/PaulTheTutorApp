//
//  PickRangeVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 12/13/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

class PickRangeVC: UIViewController {
    
    let questionLabel = PTTitleLabel(textAlignment: .left, fontSize: 20)
    
    let firstNumberMinLabel = PTTitleLabel(textAlignment: .left, fontSize: 20)
    let firstNumberMinTextfield = PTTextField(frame: .zero)
    
    let firstNumberMaxLabel = PTTitleLabel(textAlignment: .left, fontSize: 20)
    let firstNumberMaxTextfield = PTTextField(frame: .zero)
    
    let secondNumberMinLabel = PTTitleLabel(textAlignment: .left, fontSize: 20)
    let secondNumberMinTextfield = PTTextField(frame: .zero)
    
    let secondNumberMaxLabel = PTTitleLabel(textAlignment: .left, fontSize: 20)
    let secondNumberMaxTextfield = PTTextField(frame: .zero)
    
    let submitButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "submit")
    let padding = Padding.standard
    let smallPadding = Padding.small
    
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
        questionLabel.text = "What range do you want to focus on?"
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            questionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            questionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            questionLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureFirstNumberMinLabel() {
        firstNumberMinLabel.text = "Min for 1st Number"
        
        NSLayoutConstraint.activate([
            firstNumberMinLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: padding),
            firstNumberMinLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            firstNumberMinLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding)
        ])
    }
    
    private func configureFirstNumberMinTextfield() {
        NSLayoutConstraint.activate([
            firstNumberMinTextfield.topAnchor.constraint(equalTo: firstNumberMinLabel.bottomAnchor, constant: smallPadding),
            firstNumberMinTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            firstNumberMinTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            firstNumberMinTextfield.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureFirstNumberMaxLabel() {
        firstNumberMaxLabel.text = "Max for 1st Number"
        
        NSLayoutConstraint.activate([
            firstNumberMaxLabel.topAnchor.constraint(equalTo: firstNumberMinTextfield.bottomAnchor, constant: padding),
            firstNumberMaxLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            firstNumberMaxLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding)
        ])
    }
    
    private func configureFirstNumberMaxTextfield() {
        NSLayoutConstraint.activate([
            firstNumberMaxTextfield.topAnchor.constraint(equalTo: firstNumberMaxLabel.bottomAnchor, constant: smallPadding),
            firstNumberMaxTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            firstNumberMaxTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            firstNumberMaxTextfield.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureSecondNumberMinLabel() {
        secondNumberMinLabel.text = "Other number's min"
        
        NSLayoutConstraint.activate([
            secondNumberMinLabel.topAnchor.constraint(equalTo: firstNumberMaxTextfield.bottomAnchor, constant: padding),
            secondNumberMinLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            secondNumberMinLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding)
        ])
    }
    
    private func configureSecondNumberMinTextfield() {
        NSLayoutConstraint.activate([
            secondNumberMinTextfield.topAnchor.constraint(equalTo: secondNumberMinLabel.bottomAnchor, constant: smallPadding),
            secondNumberMinTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            secondNumberMinTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            secondNumberMinTextfield.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureSecondNumberMaxLabel() {
        secondNumberMaxLabel.text = "Other number's max"
        
        NSLayoutConstraint.activate([
            secondNumberMaxLabel.topAnchor.constraint(equalTo: secondNumberMinTextfield.bottomAnchor, constant: padding),
            secondNumberMaxLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            secondNumberMaxLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding)
        ])
    }
    
    private func configureSecondNumberMaxTextfield() {
        NSLayoutConstraint.activate([
            secondNumberMaxTextfield.topAnchor.constraint(equalTo: secondNumberMaxLabel.bottomAnchor, constant: smallPadding),
            secondNumberMaxTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            secondNumberMaxTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            secondNumberMaxTextfield.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureSubmitButton() {
        submitButton.addTarget(self, action: #selector(submitNumberOfProblems), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: secondNumberMaxTextfield.bottomAnchor, constant: padding),
            submitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            submitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
