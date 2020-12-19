//
//  TypeOfIntegersVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 12/13/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

class TypeOfIntegersVC: UIViewController {
    
    let questionLabel = PTTitleLabel(textAlignment: .left, fontSize: 20)
    
    let doublesButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "doubles")
    let oneDigitButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "one digit")
    let hardOneDigitsButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "hard one digits (4-9)")
    let zeroToTwelveButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "0 to 12")
    let oneToTwoDigitsButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "one to two digits")
    let multipleDigitsButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "multiple digits")
    let focusOnANumberButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "focus on a number")
    let pickTheRangeButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "pick the range")
    
    let padding = Padding.standard
    
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
    
}


// MARK: - Configuration Functions

extension TypeOfIntegersVC {
    
    func configureUI() {
        configureViewController()
        configureQuestionLabel()
        configureDoublesButton()
        configureOneDigitButton()
        configureHardOneDigitsButton()
        configureZeroToTwelveButton()
        configureOneToTwoDigitsButton()
        configureMultipleDigitsButton()
        configureFocusOnANumberButton()
        configurePickTheRangeButton()
    }
    
    private func configureViewController() {
        view.backgroundColor = Colors.paulLightGreen
        view.addSubviews(questionLabel, doublesButton, oneDigitButton, hardOneDigitsButton, zeroToTwelveButton, oneToTwoDigitsButton, multipleDigitsButton, focusOnANumberButton, pickTheRangeButton)
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
    
    private func configureDoublesButton() {
        doublesButton.addTarget(self, action: #selector(selectDoubles), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            doublesButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: padding),
            doublesButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            doublesButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            doublesButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureOneDigitButton() {
        oneDigitButton.addTarget(self, action: #selector(selectOneDigit), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            oneDigitButton.topAnchor.constraint(equalTo: doublesButton.bottomAnchor, constant: padding),
            oneDigitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            oneDigitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            oneDigitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureHardOneDigitsButton() {
        hardOneDigitsButton.addTarget(self, action: #selector(selectHardOneDigits), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            hardOneDigitsButton.topAnchor.constraint(equalTo: oneDigitButton.bottomAnchor, constant: padding),
            hardOneDigitsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            hardOneDigitsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            hardOneDigitsButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureZeroToTwelveButton() {
        zeroToTwelveButton.addTarget(self, action: #selector(selectZeroToTwelve), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            zeroToTwelveButton.topAnchor.constraint(equalTo: hardOneDigitsButton.bottomAnchor, constant: padding),
            zeroToTwelveButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            zeroToTwelveButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            zeroToTwelveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureOneToTwoDigitsButton() {
        oneToTwoDigitsButton.addTarget(self, action: #selector(selectOneToTwoDigits), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            oneToTwoDigitsButton.topAnchor.constraint(equalTo: zeroToTwelveButton.bottomAnchor, constant: padding),
            oneToTwoDigitsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            oneToTwoDigitsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            oneToTwoDigitsButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureMultipleDigitsButton() {
        multipleDigitsButton.addTarget(self, action: #selector(selectMultipleDigits), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            multipleDigitsButton.topAnchor.constraint(equalTo: oneToTwoDigitsButton.bottomAnchor, constant: padding),
            multipleDigitsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            multipleDigitsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            multipleDigitsButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureFocusOnANumberButton() {
        focusOnANumberButton.addTarget(self, action: #selector(selectFocusOnANumber), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            focusOnANumberButton.topAnchor.constraint(equalTo: multipleDigitsButton.bottomAnchor, constant: padding),
            focusOnANumberButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            focusOnANumberButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            focusOnANumberButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configurePickTheRangeButton() {
        pickTheRangeButton.addTarget(self, action: #selector(selectPickTheRange), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            pickTheRangeButton.topAnchor.constraint(equalTo: focusOnANumberButton.bottomAnchor, constant: padding),
            pickTheRangeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            pickTheRangeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            pickTheRangeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
