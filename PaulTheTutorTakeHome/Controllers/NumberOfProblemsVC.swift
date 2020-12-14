//
//  NumberOfProblemsVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 12/13/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

class NumberOfProblemsVC: UIViewController {
    
    let questionLabel = PTTitleLabel(textAlignment: .left, fontSize: 20)
    let numberOfProblemsTextfield = PTTextField(frame: .zero)
    let submitButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "submit")
    let padding = Padding.standard
    
    let parameters = ProblemSetParameters.shared
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc func submitNumberOfProblems() {
        guard let text = numberOfProblemsTextfield.text, !text.isEmpty, let numberOfProblems = Int(text) else {
            print("Alert: Please enter a whole number greater than zero")
            return
        }
        
        view.endEditing(true)
        parameters.numberOfProblems = numberOfProblems
        
        var problemSet = ProblemSet(problemSetParameters: parameters)
        problemSet.generateProblems()
        
        navigateToNextVC(with: problemSet)
    }
    
    private func navigateToNextVC(with problemSet: ProblemSet) {
        let vc = ProblemSetVC(problemSet: problemSet)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


// MARK: - Configuration Functions

extension NumberOfProblemsVC {
    
    func configureUI() {
        configureViewController()
        configureQuestionLabel()
        configureNumberOfProblemsTextfield()
        configureSubmitButton()
    }
    
    private func configureViewController() {
        view.backgroundColor = Colors.paulLightGreen
        view.addDismissKeyboardTapGesture()
        view.addSubviews(questionLabel, numberOfProblemsTextfield, submitButton)
    }
    
    private func configureQuestionLabel() {
        questionLabel.text = "Number of problems?"
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            questionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            questionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            questionLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureNumberOfProblemsTextfield() {
        NSLayoutConstraint.activate([
            numberOfProblemsTextfield.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: padding),
            numberOfProblemsTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            numberOfProblemsTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            numberOfProblemsTextfield.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureSubmitButton() {
        submitButton.addTarget(self, action: #selector(submitNumberOfProblems), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: numberOfProblemsTextfield.bottomAnchor, constant: padding),
            submitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            submitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
