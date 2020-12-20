//
//  OperationsVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 12/13/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

class OperationsVC: UIViewController {
    
    let questionLabel = PTTitleLabel(textAlignment: .left, fontSize: 20, text: "What shall we do?")
    let additionButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "addition")
    let subtractionButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "subtraction")
    let multiplicationButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "multiplication")
    
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
    
    @objc func selectMultiplication() {
        parameters.operation = .multiplication
        navigateToNextVC()
    }
    
    private func navigateToNextVC() {
        let vc = TypeOfIntegersVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = Colors.paulLightGreen
        view.addSubviews(questionLabel, additionButton, subtractionButton, multiplicationButton)
        
        questionLabel.addFlexWidthSetHeightConstraints(to: view)
        
        additionButton.addTarget(self, action: #selector(selectAddition), for: .touchUpInside)
        additionButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: questionLabel)
        
        subtractionButton.addTarget(self, action: #selector(selectSubtraction), for: .touchUpInside)
        subtractionButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: additionButton)
        
        multiplicationButton.addTarget(self, action: #selector(selectMultiplication), for: .touchUpInside)
        multiplicationButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: subtractionButton)
    }
    
}
