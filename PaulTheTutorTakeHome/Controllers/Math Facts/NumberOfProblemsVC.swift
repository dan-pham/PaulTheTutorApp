//
//  NumberOfProblemsVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 12/13/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

class NumberOfProblemsVC: UIViewController {
    
    let questionLabel = PTTitleLabel(textAlignment: .left, fontSize: 20, text: "Number of problems?")
    let numberOfProblemsTextfield = PTTextField(frame: .zero)
    let submitButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "submit")
    
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
    
    private func configureUI() {
        view.backgroundColor = Colors.paulLightGreen
        view.addDismissKeyboardTapGesture()
        view.addInputAccessoryForTextFields(textFields: [numberOfProblemsTextfield], dismissable: true)
        view.addSubviews(questionLabel, numberOfProblemsTextfield, submitButton)
        
        questionLabel.addFlexWidthSetHeightConstraints(to: view)
        
        let initialProblems = 15
        numberOfProblemsTextfield.text = "\(initialProblems)"
        numberOfProblemsTextfield.addFlexWidthSetHeightConstraints(to: view, aboveComponent: questionLabel)
        
        submitButton.addTarget(self, action: #selector(submitNumberOfProblems), for: .touchUpInside)
        submitButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: numberOfProblemsTextfield)
    }
    
}
