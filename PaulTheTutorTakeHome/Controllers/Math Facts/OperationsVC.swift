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
    let scrollView = PTScrollView(heightConstraint: 540)
    
    let additionButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "addition")
    let subtractionButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "subtraction")
    let additionSubtractionButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "addition & subtraction")
    let doublesMultiplicationButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "doubles multiplication")
    let multiplicationButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "multiplication")
    let divisionButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "division")
    let multiplicationDivisionButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "multiplication & division")
    
    let parameters = ProblemSetParameters.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        parameters.numberType = .integers
    }
    
    @objc func selectAddition() {
        parameters.operation = [.addition]
        navigationController?.pushViewController(TypeOfIntegersVC(), animated: true)
    }
    
    @objc func selectSubtraction() {
        parameters.operation = [.subtraction]
        navigationController?.pushViewController(TypeOfIntegersVC(), animated: true)
    }
    
    @objc func selectAdditionSubtraction() {
        parameters.operation = [.addition, .subtraction]
        navigationController?.pushViewController(TypeOfIntegersVC(), animated: true)
    }
    
    @objc func selectDoublesMultiplication() {
        parameters.operation = [.multiplication]
        parameters.integerType = .doubles
        
        // For now, just do positive numbers
        parameters.integerSign = .positive
        
        let vc = NumberOfProblemsVC() // PositiveNegativeIntegersVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func selectMultiplication() {
        parameters.operation = [.multiplication]
        navigationController?.pushViewController(TypeOfIntegersVC(), animated: true)
    }
    
    @objc func selectDivision() {
        parameters.operation = [.division]
        navigationController?.pushViewController(TypeOfDivisionVC(), animated: true)
    }
    
    @objc func selectMultiplicationDivistion() {
        parameters.operation = [.multiplication, .division]
        navigationController?.pushViewController(TypeOfDivisionVC(), animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = Colors.paulLightGreen
        view.addSubviews(questionLabel, scrollView)
        
        questionLabel.addFlexWidthSetHeightConstraints(to: view)
        
        scrollView.addSubviews(additionButton, subtractionButton, additionSubtractionButton, doublesMultiplicationButton, multiplicationButton, divisionButton, multiplicationDivisionButton)
        scrollView.addScrollViewConstraints(to: view, aboveComponent: questionLabel)
        
        additionButton.addTarget(self, action: #selector(selectAddition), for: .touchUpInside)
        additionButton.addFlexWidthSetHeightConstraints(to: scrollView, isScrollViewTop: true)
        
        subtractionButton.addTarget(self, action: #selector(selectSubtraction), for: .touchUpInside)
        subtractionButton.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: additionButton)
        
        additionSubtractionButton.addTarget(self, action: #selector(selectAdditionSubtraction), for: .touchUpInside)
        additionSubtractionButton.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: subtractionButton)
        
        doublesMultiplicationButton.addTarget(self, action: #selector(selectDoublesMultiplication), for: .touchUpInside)
        doublesMultiplicationButton.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: additionSubtractionButton)
        
        multiplicationButton.addTarget(self, action: #selector(selectMultiplication), for: .touchUpInside)
        multiplicationButton.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: doublesMultiplicationButton)
        
        divisionButton.addTarget(self, action: #selector(selectDivision), for: .touchUpInside)
        divisionButton.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: multiplicationButton)
        
        multiplicationDivisionButton.addTarget(self, action: #selector(selectMultiplicationDivistion), for: .touchUpInside)
        multiplicationDivisionButton.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: divisionButton)
    }
    
}
