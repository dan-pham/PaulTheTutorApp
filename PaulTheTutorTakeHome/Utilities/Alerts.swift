//
//  Alerts.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/11/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

enum Alerts {
    
    // MARK: - Basic Alerts
    
    private static func showBasicAlert(on vc: UIViewController, withTitle title: String, message: String) {
        let alertVC = PTAlertVC(title: title, message: message, isConfirmationAlert: false)
        alertVC.delegate = vc as? AlertActionDelegate
        
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        DispatchQueue.main.async {
            vc.present(alertVC, animated: true)
        }
    }
    
    static func showEmptyInputAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, withTitle: "Oops!", message: "You forgot to enter an answer.")
    }
    
    static func showNoHintsAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, withTitle: "No Hint Available", message: "Currently no hints available for this operation.")
    }
    
    static func showIncorrectAnswerAlert(on vc: UIViewController) {
        showBasicAlert(on: vc, withTitle: "Try Again!", message: "Sorry, that answer is incorrect.")
    }
    
    
    // MARK: - Confirmation Alerts
    
    private static func showConfirmationAlert(on vc: UIViewController, message: String) {
        let alertVC = PTAlertVC(title: "Are you sure?", message: message, isConfirmationAlert: true)
        alertVC.delegate = vc as? AlertActionDelegate
        
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        DispatchQueue.main.async {
            vc.present(alertVC, animated: true)
        }
    }
    
    static func showLeaveConfirmationAlert(on vc: UIViewController) {
        let message = "Your progress won't be saved."
        showConfirmationAlert(on: vc, message: message)
    }
    
}
