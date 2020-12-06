//
//  ProblemSetVC+Ext.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/11/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

// MARK: - ResultsDelegate Functions

extension ProblemSetVC: ResultsDelegate {
    
    func didSelectHome() {
        dismiss(animated: true) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}


// MARK: - AlertActionDelegate Functions

extension ProblemSetVC: AlertActionDelegate {
    
    func executeAction() {
        dismiss(animated: true) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}
