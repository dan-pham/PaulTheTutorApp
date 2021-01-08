//
//  TypeOfDivisionVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 12/19/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

class TypeOfDivisionVC: UIViewController {
    
    let questionLabel = PTTitleLabel(textAlignment: .left, fontSize: 20, text: "What type of division?")
    let evenButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "goes in evenly")
    let remaindersButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "answers with remainders")
    let decimalsButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "answers with decimals")
    
    let parameters = ProblemSetParameters.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc func selectEven() {
        parameters.divisionType = .even
        navigationController?.pushViewController(TypeOfIntegersVC(), animated: true)
    }
    
    @objc func selectRemainders() {
        parameters.divisionType = .remainders
        navigationController?.pushViewController(TypeOfIntegersVC(), animated: true)
    }
    
    @objc func selectDecimals() {
        parameters.divisionType = .decimals
        navigationController?.pushViewController(TypeOfIntegersVC(), animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = Colors.paulLightGreen
        view.addSubviews(questionLabel, evenButton, remaindersButton, decimalsButton)
        
        questionLabel.addFlexWidthSetHeightConstraints(to: view)
        
        evenButton.addTarget(self, action: #selector(selectEven), for: .touchUpInside)
        evenButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: questionLabel)
        
        remaindersButton.addTarget(self, action: #selector(selectRemainders), for: .touchUpInside)
        remaindersButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: evenButton)
        
        decimalsButton.addTarget(self, action: #selector(selectDecimals), for: .touchUpInside)
        decimalsButton.addFlexWidthSetHeightConstraints(to: view, aboveComponent: remaindersButton)
    }
    
}
