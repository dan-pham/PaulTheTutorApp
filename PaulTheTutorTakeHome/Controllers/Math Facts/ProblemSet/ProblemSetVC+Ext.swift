//
//  ProblemSetVC+Ext.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/11/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit


// MARK: - TextFieldDelegate Functions {

extension ProblemSetVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.placeholder == "Answer" || textField.placeholder == "Quotient" || textField.placeholder == "Remainder" {
            textField.placeholder = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == answerTextField {
            if textField.placeholder == "" {
                textField.placeholder = problemSet.parameters.divisionType == .remainders ? "Quotient" : "Answer"
            }
        } else if textField == remainderTextField {
            if textField.placeholder == "" {
                textField.placeholder = "Remainder"
            }
        }
    }
    
}


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
