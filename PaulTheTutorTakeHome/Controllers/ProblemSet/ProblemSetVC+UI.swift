//
//  ProblemSetVC+UI.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/11/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

// MARK: - Configuration Functions

extension ProblemSetVC {
    
    func configureViewController() {
        view.backgroundColor = Colors.paulLightGreen
        view.createDismissKeyboardTapGesture()
        title = problemSet.title
        view.addSubviews(totalProblemsLabel, containerView)
    }
    
    func configureNavBar() {
        let backItem = UIBarButtonItem(title: "Leave", style: .plain, target: self, action: #selector(presentLeaveConfirmationAlert))
        backItem.tintColor = Colors.paulDarkGreen
        navigationItem.leftBarButtonItem = backItem
    }
    
    func configureTotalProblemsLabel() {
        NSLayoutConstraint.activate([
            totalProblemsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            totalProblemsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            totalProblemsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
    
    func configureContainerView() {
        containerView.addSubviews(problemLabel, dividerView, answerTextField, encouragementLabel, nextButton)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: totalProblemsLabel.bottomAnchor, constant: padding),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func configureProblemLabel() {
        problemLabel.numberOfLines = 1
        
        NSLayoutConstraint.activate([
            problemLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            problemLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            problemLabel.trailingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: padding)
        ])
    }
    
    func configureDividerView() {
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        dividerView.backgroundColor = .black
        
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: problemLabel.bottomAnchor),
            dividerView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            dividerView.widthAnchor.constraint(equalToConstant: 100),
            dividerView.heightAnchor.constraint(equalToConstant: 2)
        ])
    }
    
    func configureAnswerTextField() {
        NSLayoutConstraint.activate([
            answerTextField.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: padding),
            answerTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            answerTextField.widthAnchor.constraint(equalToConstant: 100),
            answerTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureNextButton() {
        nextButton.addTarget(self, action: #selector(setupNextEquation), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            nextButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            nextButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureEncouragementLabel() {
        encouragementLabel.numberOfLines = 2
        encouragementLabel.lineBreakMode = .byWordWrapping
        
        NSLayoutConstraint.activate([
            encouragementLabel.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -padding),
            encouragementLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            encouragementLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
        ])
    }
    
}
