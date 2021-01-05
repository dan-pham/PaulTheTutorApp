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
    
    func configureUI() {
        configureViewController()
        configureNavBar()
        configureTotalProblemsLabel()
        configureContainerView()
        configureProblemLabel()
        configureAnswerTextField()
        configureRemainderTextField()
        configureRoundingLabel()
        configureNextButton()
//        configureEncouragementLabel()
        configureHintButton()
    }
    
    private func configureViewController() {
        view.backgroundColor = Colors.paulLightGreen
        view.addDismissKeyboardTapGesture()
//        title = problemSet.title
        view.addSubviews(totalProblemsLabel, containerView, hintButton)
    }
    
    private func configureNavBar() {
        let backItem = UIBarButtonItem(title: "Leave", style: .plain, target: self, action: #selector(presentLeaveConfirmationAlert))
        backItem.tintColor = Colors.paulDarkGreen
        navigationItem.leftBarButtonItem = backItem
    }
    
    private func configureTotalProblemsLabel() {
        NSLayoutConstraint.activate([
            totalProblemsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            totalProblemsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            totalProblemsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
    
    private func configureContainerView() {
        containerView.addSubviews(problemLabel, answerTextField, remainderTextField, roundingLabel, nextButton) // encouragementLabel, nextButton)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: totalProblemsLabel.bottomAnchor, constant: padding),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    private func configureProblemLabel() {
        problemLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            problemLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            problemLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            problemLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
        ])
    }
    
    private func configureAnswerTextField() {
        answerTextField.delegate = self
        let isRemainderProblem = problemSet.parameters.divisionType == .remainders
        answerTextField.placeholder = isRemainderProblem ? "Quotient" : "Answer"
        
        NSLayoutConstraint.activate([
            answerTextField.topAnchor.constraint(equalTo: problemLabel.bottomAnchor, constant: padding),
            answerTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        if isRemainderProblem {
            NSLayoutConstraint.activate([
                answerTextField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
                answerTextField.trailingAnchor.constraint(equalTo: containerView.centerXAnchor, constant: -padding / 2)
            ])
        } else {
            NSLayoutConstraint.activate([
                answerTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                answerTextField.widthAnchor.constraint(equalToConstant: 150),
            ])
        }
    
    }
    
    private func configureRemainderTextField() {
        remainderTextField.delegate = self
        remainderTextField.placeholder = "Remainder"
        
        if problemSet.parameters.divisionType != .remainders {
            remainderTextField.isHidden = true
        }
        
        NSLayoutConstraint.activate([
            remainderTextField.centerYAnchor.constraint(equalTo: answerTextField.centerYAnchor),
            remainderTextField.leadingAnchor.constraint(equalTo: answerTextField.trailingAnchor, constant: padding),
            remainderTextField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            remainderTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureRoundingLabel() {
        roundingLabel.text = "Round answer up to 2 decimal places"
        
        if problemSet.parameters.divisionType != .decimals {
            roundingLabel.isHidden = true
        }
        
        NSLayoutConstraint.activate([
            roundingLabel.topAnchor.constraint(equalTo: answerTextField.bottomAnchor, constant: Padding.small),
            roundingLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Padding.small),
            roundingLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Padding.small)
        ])
    }
    
    private func configureNextButton() {
        nextButton.addTarget(self, action: #selector(setupNextEquation), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            nextButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            nextButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
//    private func configureEncouragementLabel() {
//        encouragementLabel.numberOfLines = 2
//        encouragementLabel.lineBreakMode = .byWordWrapping
//
//        NSLayoutConstraint.activate([
//            encouragementLabel.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -padding),
//            encouragementLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
//            encouragementLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
//        ])
//    }
    
    private func configureHintButton() {
        hintButton.addTarget(self, action: #selector(showHint), for: .touchUpInside)
        
        hintButton.layer.borderWidth = 2
        hintButton.layer.borderColor = Colors.paulDarkGreen.cgColor
        
        NSLayoutConstraint.activate([
            hintButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: padding),
            hintButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            hintButton.widthAnchor.constraint(equalToConstant: 60),
            hintButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
}
