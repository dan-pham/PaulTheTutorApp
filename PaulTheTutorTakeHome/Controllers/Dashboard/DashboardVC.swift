//
//  DashboardVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 12/13/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {
    
    let questionLabel = PTTitleLabel(textAlignment: .left, fontSize: 20)
    let integerButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "integers")
    let padding = Padding.standard
    
    let parameters = ProblemSetParameters.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc func selectIntegers() {
        parameters.numberType = .integers
        navigateToNextVC()
    }
    
    private func navigateToNextVC() {
        let vc = OperationsVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


// MARK: - Configuration Functions

extension DashboardVC {
    
    func configureUI() {
        configureViewController()
        configureNavBar()
        configureQuestionLabel()
        configureIntegersButton()
    }
    
    private func configureViewController() {
        title = "Math Facts"
        view.backgroundColor = Colors.paulLightGreen
        view.addSubviews(questionLabel, integerButton)
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
    }
    
    private func configureQuestionLabel() {
        questionLabel.text = "What type of numbers?"
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            questionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            questionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            questionLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureIntegersButton() {
        integerButton.addTarget(self, action: #selector(selectIntegers), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            integerButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: padding),
            integerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            integerButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            integerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
