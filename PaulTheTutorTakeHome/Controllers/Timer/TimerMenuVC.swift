//
//  TimerMenuVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 1/5/21.
//  Copyright © 2021 Dan Pham. All rights reserved.
//

import DLRadioButton
import UIKit

class TimerMenuVC: UIViewController {
    
    let testTypeLabel = PTTitleLabel(textAlignment: .left, fontSize: 20, text: "What test are you taking?")
    let actButton = PTRadioButton(title: "ACT", isIconSquare: false)
    let satButton = PTRadioButton(title: "SAT", isIconSquare: false)
    
    let testExtensionLabel = PTTitleLabel(textAlignment: .left, fontSize: 20, text: "Are you taking the test with extended time?")
    let totalTimeLabel = PTBodyLabel(textAlignment: .left, fontSize: 18)
    
    let notExtendedButton = PTRadioButton(title: "Not extended", isIconSquare: false)
    let extendedButton = PTRadioButton(title: "Extended", isIconSquare: false)
    
    let nextButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "Next")
    
    let parameters = TimerParameters.shared
    let padding = Padding.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setDefaultRadioButtons()
    }
    
    @objc func selectACT() {
        parameters.testType = .act
    }
    
    @objc func selectSAT() {
        parameters.testType = .sat
    }
    
    @objc func selectNotExtended() {
        parameters.isExtended = false
    }
    
    @objc func selectExtended() {
        parameters.isExtended = true
    }
    
    @objc func navigateToNextVC() {
        let vc = TestSectionsVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setDefaultRadioButtons() {
        actButton.isSelected = true
        selectACT()
        
        notExtendedButton.isSelected = true
        selectNotExtended()
    }
    
    private func configureUI() {
        view.backgroundColor = Colors.paulLightGreen
        view.addSubviews(testTypeLabel, actButton, satButton, testExtensionLabel, totalTimeLabel, notExtendedButton, extendedButton, nextButton)
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        testTypeLabel.addFlexWidthSetHeightConstraints(to: view)
        configureTestTypeRadioButtons()
        
        testExtensionLabel.numberOfLines = 2
        testExtensionLabel.addFlexWidthSetHeightConstraints(to: view, aboveComponent: actButton, naturalHeight: true)
        
        totalTimeLabel.text = "Without Essay: 4 hours, 30 minutes\nWith Essay: 5 hours, 15 minutes"
        totalTimeLabel.numberOfLines = 2
        NSLayoutConstraint.activate([
            totalTimeLabel.topAnchor.constraint(equalTo: testExtensionLabel.bottomAnchor, constant: Padding.small),
            totalTimeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            totalTimeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
        ])
        
        configureTestExtensionRadioButtons()
        
        nextButton.addTarget(self, action: #selector(navigateToNextVC), for: .touchUpInside)
        nextButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: notExtendedButton)
    }
    
    private func configureTestTypeRadioButtons() {
        actButton.otherButtons = [satButton]
        actButton.addTarget(self, action: #selector(selectACT), for: .touchUpInside)
        satButton.addTarget(self, action: #selector(selectSAT), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actButton.topAnchor.constraint(equalTo: testTypeLabel.bottomAnchor, constant: padding),
            actButton.widthAnchor.constraint(equalToConstant: 70),
            actButton.heightAnchor.constraint(equalToConstant: 35),
            
            satButton.leadingAnchor.constraint(equalTo: actButton.trailingAnchor, constant: Padding.large),
            satButton.topAnchor.constraint(equalTo: testTypeLabel.bottomAnchor, constant: padding),
            satButton.widthAnchor.constraint(equalToConstant: 70),
            satButton.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func configureTestExtensionRadioButtons() {
        notExtendedButton.otherButtons = [extendedButton]
        notExtendedButton.addTarget(self, action: #selector(selectNotExtended), for: .touchUpInside)
        extendedButton.addTarget(self, action: #selector(selectExtended), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            notExtendedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            notExtendedButton.topAnchor.constraint(equalTo: totalTimeLabel.bottomAnchor, constant: padding),
            notExtendedButton.widthAnchor.constraint(equalToConstant: 155),
            notExtendedButton.heightAnchor.constraint(equalToConstant: 35),
            
            extendedButton.leadingAnchor.constraint(equalTo: notExtendedButton.trailingAnchor, constant: Padding.large),
            extendedButton.topAnchor.constraint(equalTo: totalTimeLabel.bottomAnchor, constant: padding),
            extendedButton.widthAnchor.constraint(equalToConstant: 120),
            extendedButton.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
}
