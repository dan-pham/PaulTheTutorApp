//
//  PositiveNegativeIntegersVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 12/13/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

class PositiveNegativeIntegersVC: UIViewController {
    
    let questionLabel = PTTitleLabel(textAlignment: .left, fontSize: 20, text: "Type of Integers")
    let positiveIntegersButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "positive integers")
    let negativeAndPositiveIntegersButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "negative and positive integers")
    
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
    
    private func configureUI() {
        view.backgroundColor = Colors.paulLightGreen
        view.addSubviews(questionLabel, positiveIntegersButton, negativeAndPositiveIntegersButton)
        
        questionLabel.addFlexWidthSetHeightConstraints(to: view)
        
        positiveIntegersButton.addTarget(self, action: #selector(selectPositiveIntegers), for: .touchUpInside)
        positiveIntegersButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: questionLabel)
        
        negativeAndPositiveIntegersButton.addTarget(self, action: #selector(selectNegativeAndPositiveIntegers), for: .touchUpInside)
        negativeAndPositiveIntegersButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: positiveIntegersButton)
    }
    
}
