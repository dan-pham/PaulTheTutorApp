//
//  TypeOfIntegersVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 12/13/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

class TypeOfIntegersVC: UIViewController {
    
    let questionLabel = PTTitleLabel(textAlignment: .left, fontSize: 20, text: "Type of Integers")
    let scrollView = PTScrollView(heightConstraint: 620)
    
    let doublesButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "doubles")
    let oneDigitButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "one digit")
    let hardOneDigitsButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "hard one digits (4-9)")
//    let zeroToTwelveButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "0 to 12")
    let oneToTwoDigitsButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "one to two digits")
    let multipleDigitsButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "multiple digits")
    let focusOnANumberButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "focus on a number")
    let pickTheRangeButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "pick the range")
    
    let parameters = ProblemSetParameters.shared
    
    lazy var isAdditionOrMultiplication: Bool = { [unowned self] in
        if parameters.operation == [.addition] || parameters.operation == [.multiplication] { return true }
        return false
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc func selectDoubles() {
        parameters.integerType = [.doubles]
        navigateToPositiveNegativeIntegersVC()
    }
    
    @objc func selectOneDigit() {
        parameters.integerType = [.oneDigit]
        navigateToPositiveNegativeIntegersVC()
    }
    
    @objc func selectHardOneDigits() {
        parameters.integerType = [.hardOneDigits]
        navigateToPositiveNegativeIntegersVC()
    }
    
//    @objc func selectZeroToTwelve() {
//        parameters.integerType = .zeroToTwelve
//        navigateToPositiveNegativeIntegersVC()
//    }
    
    @objc func selectFocusOnANumber() {
        parameters.integerType = [.focusOnANumber]
        navigateToFocusNumberVC()
    }
    
    @objc func selectOneToTwoDigits() {
        parameters.integerType = [.oneToTwoDigits]
        navigateToPositiveNegativeIntegersVC()
    }
    
    @objc func selectMultipleDigits() {
        parameters.integerType = [.multipleDigits]
        navigateToPositiveNegativeIntegersVC()
    }
    
    @objc func selectPickTheRange() {
        parameters.integerType = [.pickTheRange]
        navigateToPickRangeVC()
    }
    
    private func navigateToPositiveNegativeIntegersVC() {
        // For now, just do positive numbers
        parameters.integerSign = .positive
        let vc = NumberOfProblemsVC() // PositiveNegativeIntegersVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func navigateToFocusNumberVC() {
        let vc = FocusNumberVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func navigateToPickRangeVC() {
        let vc = PickRangeVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = Colors.paulLightGreen
        view.addSubviews(questionLabel, scrollView)
        
        questionLabel.addFlexWidthSetHeightConstraints(to: view)
        
        scrollView.addSubviews(doublesButton, oneDigitButton, hardOneDigitsButton, /*zeroToTwelveButton,*/ focusOnANumberButton, oneToTwoDigitsButton, multipleDigitsButton,  pickTheRangeButton)
        scrollView.addScrollViewConstraints(to: view, aboveComponent: questionLabel)
        
        doublesButton.isHidden = isAdditionOrMultiplication
        doublesButton.addTarget(self, action: #selector(selectDoubles), for: .touchUpInside)
        doublesButton.addFlexWidthSetHeightConstraints(to: scrollView, isScrollViewTop: true)
        
        oneDigitButton.addTarget(self, action: #selector(selectOneDigit), for: .touchUpInside)
        oneDigitButton.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: isAdditionOrMultiplication ? nil : doublesButton, isScrollViewTop: isAdditionOrMultiplication)
        
        hardOneDigitsButton.addTarget(self, action: #selector(selectHardOneDigits), for: .touchUpInside)
        hardOneDigitsButton.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: oneDigitButton)
        
//        zeroToTwelveButton.addTarget(self, action: #selector(selectZeroToTwelve), for: .touchUpInside)
//        zeroToTwelveButton.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: hardOneDigitsButton)
        
        focusOnANumberButton.addTarget(self, action: #selector(selectFocusOnANumber), for: .touchUpInside)
        focusOnANumberButton.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: hardOneDigitsButton)
        
        oneToTwoDigitsButton.addTarget(self, action: #selector(selectOneToTwoDigits), for: .touchUpInside)
        oneToTwoDigitsButton.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: focusOnANumberButton)
        
        multipleDigitsButton.addTarget(self, action: #selector(selectMultipleDigits), for: .touchUpInside)
        multipleDigitsButton.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: oneToTwoDigitsButton)
        
        pickTheRangeButton.addTarget(self, action: #selector(selectPickTheRange), for: .touchUpInside)
        pickTheRangeButton.addFlexWidthSetHeightConstraints(to: scrollView, aboveComponent: multipleDigitsButton)
    }
    
}
