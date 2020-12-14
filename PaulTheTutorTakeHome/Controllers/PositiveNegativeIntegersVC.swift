//
//  PositiveNegativeIntegersVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 12/13/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

class PositiveNegativeIntegersVC: UIViewController {
    
    let questionLabel = PTTitleLabel(textAlignment: .left, fontSize: 20)
    let positiveIntegersButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "positive integers")
    let negativeAndPositiveIntegersButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "negative and positive integers")
    
    let padding = Padding.standard
    
    let parameters = ProblemSetParameters.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc func selectPositiveIntegers() {
        parameters.integerSign = .positive
        navigateToNextVC()
    }
    
    @objc func selectNegativeAndPositiveIntegers() {
        parameters.integerSign = .negativeAndPositive
        navigateToNextVC()
    }
    
    private func navigateToNextVC() {
        let vc = NumberOfProblemsVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


// MARK: - Configuration Functions

extension PositiveNegativeIntegersVC {
    
    func configureUI() {
        configureViewController()
        configureQuestionLabel()
        configurePositiveIntegersButton()
        configureNegativeAndPositiveIntegersButton()
    }
    
    private func configureViewController() {
        view.backgroundColor = Colors.paulLightGreen
        view.addSubviews(questionLabel, positiveIntegersButton, negativeAndPositiveIntegersButton)
    }
    
    private func configureQuestionLabel() {
        questionLabel.text = "Type of Integers"
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            questionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            questionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            questionLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configurePositiveIntegersButton() {
        positiveIntegersButton.addTarget(self, action: #selector(selectPositiveIntegers), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            positiveIntegersButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: padding),
            positiveIntegersButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            positiveIntegersButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            positiveIntegersButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureNegativeAndPositiveIntegersButton() {
        negativeAndPositiveIntegersButton.addTarget(self, action: #selector(selectNegativeAndPositiveIntegers), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            negativeAndPositiveIntegersButton.topAnchor.constraint(equalTo: positiveIntegersButton.bottomAnchor, constant: padding),
            negativeAndPositiveIntegersButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            negativeAndPositiveIntegersButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            negativeAndPositiveIntegersButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
