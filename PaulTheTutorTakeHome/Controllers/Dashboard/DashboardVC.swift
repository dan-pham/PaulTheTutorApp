//
//  DashboardVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 12/13/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {
    
    let questionLabel = PTTitleLabel(textAlignment: .left, fontSize: 20, text: "What type of numbers?")
    let integerButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "integers")
    
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
        questionLabel.addFlexWidthSetHeightConstraints(to: view)
    }
    
    private func configureIntegersButton() {
        integerButton.addTarget(self, action: #selector(selectIntegers), for: .touchUpInside)
        integerButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: questionLabel)
    }
    
}
