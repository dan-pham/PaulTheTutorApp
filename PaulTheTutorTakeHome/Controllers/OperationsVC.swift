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
    
    private func navigateToNextVC() {
        let vc = TypeOfIntegersVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = Colors.paulLightGreen
        view.addSubviews(questionLabel, additionButton, subtractionButton)
        
        questionLabel.addFlexWidthSetHeightConstraints(to: view)
        
        additionButton.addTarget(self, action: #selector(selectAddition), for: .touchUpInside)
        additionButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: questionLabel)
        
        subtractionButton.addTarget(self, action: #selector(selectSubtraction), for: .touchUpInside)
        subtractionButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: additionButton)
    }
    
}
