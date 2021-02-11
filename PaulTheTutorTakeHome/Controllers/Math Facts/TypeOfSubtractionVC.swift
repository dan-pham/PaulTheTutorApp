//
//  TypeOfSubtractionVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 2/10/21.
//  Copyright © 2021 Dan Pham. All rights reserved.
//

import UIKit

class TypeOfSubtractionVC: UIViewController {
    
    let questionLabel = PTTitleLabel(textAlignment: .left, fontSize: 20, text: "Do you want borrowing?")
    let yesButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "yes")
    let noButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "no")
    
    let parameters = ProblemSetParameters.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc func selectYes() {
        parameters.subtractionType = .borrowing
        navigateToPositiveNegativeIntegersVC()
    }
    
    @objc func selectNo() {
        parameters.subtractionType = .noBorrowing
        navigateToPositiveNegativeIntegersVC()
    }
    
    private func navigateToPositiveNegativeIntegersVC() {
        // For now, just do positive numbers
        parameters.integerSign = .positive
        let vc = NumberOfProblemsVC() // PositiveNegativeIntegersVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = Colors.paulLightGreen
        view.addSubviews(questionLabel, yesButton, noButton)
        
        questionLabel.addFlexWidthSetHeightConstraints(to: view)
        
        yesButton.addTarget(self, action: #selector(selectYes), for: .touchUpInside)
        yesButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: questionLabel)
        
        noButton.addTarget(self, action: #selector(selectNo), for: .touchUpInside)
        noButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: yesButton)
    }
    
}
