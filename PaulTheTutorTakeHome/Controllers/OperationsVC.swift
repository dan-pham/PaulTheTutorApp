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
    let divisionButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "division")
    
    let parameters = ProblemSetParameters.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc func selectAddition() {
        parameters.operation = .addition
        navigationController?.pushViewController(TypeOfIntegersVC(), animated: true)
    }
    
    @objc func selectSubtraction() {
        parameters.operation = .subtraction
        navigationController?.pushViewController(TypeOfIntegersVC(), animated: true)
    }
    
    @objc func selectMultiplication() {
        parameters.operation = .multiplication
        navigationController?.pushViewController(TypeOfIntegersVC(), animated: true)
    }
    
    @objc func selectDivision() {
        parameters.operation = .division
        navigationController?.pushViewController(TypeOfDivisionVC(), animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = Colors.paulLightGreen
        view.addSubviews(questionLabel, additionButton, subtractionButton, multiplicationButton, divisionButton)
        
        questionLabel.addFlexWidthSetHeightConstraints(to: view)
        
        additionButton.addTarget(self, action: #selector(selectAddition), for: .touchUpInside)
        additionButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: questionLabel)
        
        subtractionButton.addTarget(self, action: #selector(selectSubtraction), for: .touchUpInside)
        subtractionButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: additionButton)
        
        multiplicationButton.addTarget(self, action: #selector(selectMultiplication), for: .touchUpInside)
        multiplicationButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: subtractionButton)
        
        divisionButton.addTarget(self, action: #selector(selectDivision), for: .touchUpInside)
        divisionButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: multiplicationButton)
    }
    
}
