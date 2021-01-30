//
//  MathFactsMenuVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 1/5/21.
//  Copyright © 2021 Dan Pham. All rights reserved.
//

import UIKit

class MathFactsMenuVC: UIViewController {
    
    let questionLabel = PTTitleLabel(textAlignment: .left, fontSize: 20, text: "What type of numbers?")
    let integerButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "integers")
    
    let parameters = ProblemSetParameters.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc func selectIntegers() {
        parameters.numberType = .integers
        navigateToNextVC()
    }
    
    private func navigateToNextVC() {
        let vc = OperationsVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = Colors.paulLightGreen
        view.addSubviews(questionLabel, integerButton)
        
        questionLabel.addFlexWidthSetHeightConstraints(to: view)
        
        integerButton.addTarget(self, action: #selector(selectIntegers), for: .touchUpInside)
        integerButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: questionLabel)
    }
    
}
