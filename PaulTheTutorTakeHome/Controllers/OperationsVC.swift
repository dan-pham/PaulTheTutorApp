//
//  OperationsVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 12/13/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

class OperationsVC: UIViewController {
    
    let questionLabel = PTTitleLabel(textAlignment: .left, fontSize: 20)
    let additionButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "addition")
    let subtractionButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "subtraction")
    let padding = Padding.standard
    
    let parameters = ProblemSetParameters.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc func selectAddition() {
        parameters.operation = .addition
        navigateToNextVC()
    }
    
    @objc func selectSubtraction() {
        parameters.operation = .subtraction
        navigateToNextVC()
    }
    
    private func navigateToNextVC() {
        let vc = TypeOfIntegersVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


// MARK: - Configuration Functions

extension OperationsVC {
    
    func configureUI() {
        configureViewController()
        configureQuestionLabel()
        configureAdditionButton()
        configureSubtractionButton()
    }
    
    private func configureViewController() {
        view.backgroundColor = Colors.paulLightGreen
        view.addSubviews(questionLabel, additionButton, subtractionButton)
    }
    
    private func configureQuestionLabel() {
        questionLabel.text = "What shall we do?"
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            questionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            questionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            questionLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureAdditionButton() {
        additionButton.addTarget(self, action: #selector(selectAddition), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            additionButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: padding),
            additionButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            additionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            additionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureSubtractionButton() {
        subtractionButton.addTarget(self, action: #selector(selectSubtraction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            subtractionButton.topAnchor.constraint(equalTo: additionButton.bottomAnchor, constant: padding),
            subtractionButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            subtractionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            subtractionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
