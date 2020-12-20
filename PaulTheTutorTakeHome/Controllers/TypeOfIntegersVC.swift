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
    
    let doublesButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "doubles")
    let oneDigitButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "one digit")
    let hardOneDigitsButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "hard one digits (4-9)")
    let zeroToTwelveButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "0 to 12")
    let oneToTwoDigitsButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "one to two digits")
    let multipleDigitsButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "multiple digits")
    let focusOnANumberButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "focus on a number")
    let pickTheRangeButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "pick the range")
    
    let parameters = ProblemSetParameters.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc func selectDoubles() {
        parameters.integerType = .doubles
        navigateToPositiveNegativeIntegersVC()
    }
    
    @objc func selectOneDigit() {
        parameters.integerType = .oneDigit
        navigateToPositiveNegativeIntegersVC()
    }
    
    @objc func selectHardOneDigits() {
        parameters.integerType = .hardOneDigits
        navigateToPositiveNegativeIntegersVC()
    }
    
    @objc func selectZeroToTwelve() {
        parameters.integerType = .zeroToTwelve
        navigateToPositiveNegativeIntegersVC()
    }
    
    @objc func selectOneToTwoDigits() {
        parameters.integerType = .oneToTwoDigits
        navigateToPositiveNegativeIntegersVC()
    }
    
    @objc func selectMultipleDigits() {
        parameters.integerType = .multipleDigits
        navigateToPositiveNegativeIntegersVC()
    }
    
    @objc func selectFocusOnANumber() {
        parameters.integerType = .focusOnANumber
        navigateToFocusNumberVC()
    }
    
    @objc func selectPickTheRange() {
        parameters.integerType = .pickTheRange
        navigateToPickRangeVC()
    }
    
    private func navigateToPositiveNegativeIntegersVC() {
        let vc = PositiveNegativeIntegersVC()
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
        view.addSubviews(questionLabel, doublesButton, oneDigitButton, hardOneDigitsButton, zeroToTwelveButton, oneToTwoDigitsButton, multipleDigitsButton, focusOnANumberButton, pickTheRangeButton)
        
        questionLabel.addFlexWidthSetHeightConstraints(to: view)
        
        doublesButton.addTarget(self, action: #selector(selectDoubles), for: .touchUpInside)
        doublesButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: questionLabel)
        
        oneDigitButton.addTarget(self, action: #selector(selectOneDigit), for: .touchUpInside)
        oneDigitButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: doublesButton)
        
        hardOneDigitsButton.addTarget(self, action: #selector(selectHardOneDigits), for: .touchUpInside)
        hardOneDigitsButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: oneDigitButton)
        
        zeroToTwelveButton.addTarget(self, action: #selector(selectZeroToTwelve), for: .touchUpInside)
        zeroToTwelveButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: hardOneDigitsButton)
        
        oneToTwoDigitsButton.addTarget(self, action: #selector(selectOneToTwoDigits), for: .touchUpInside)
        oneToTwoDigitsButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: zeroToTwelveButton)
        
        multipleDigitsButton.addTarget(self, action: #selector(selectMultipleDigits), for: .touchUpInside)
        multipleDigitsButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: oneToTwoDigitsButton)
        
        focusOnANumberButton.addTarget(self, action: #selector(selectFocusOnANumber), for: .touchUpInside)
        focusOnANumberButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: multipleDigitsButton)
        
        pickTheRangeButton.addTarget(self, action: #selector(selectPickTheRange), for: .touchUpInside)
        pickTheRangeButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: focusOnANumberButton)
    }
    
}
