//
//  ConfirmationVC+UI.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/11/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

// MARK: - Configuration Functions

extension ConfirmationVC {
    
    func configureViewController() {
        view.backgroundColor = Colors.blackOverlay
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissVC)))
        view.addSubview(containerView)
    }
    
    func configureContainerView() {
        containerView.addSubviews(animationView, titleLabel, numberOfProblemsLabel, confirmLabel, dismissButton, confirmButton)
        
        containerHalfWidth = containerWidth / 2 - (1.5 * padding)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: containerWidth),
            containerView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func configureAnimationView() {
        let animationViewLength: CGFloat = 50
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            animationView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            animationView.widthAnchor.constraint(equalToConstant: animationViewLength),
            animationView.heightAnchor.constraint(equalToConstant: animationViewLength)
        ])
    }
    
    func configureTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: animationView.trailingAnchor, constant: 2 * padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
        ])
    }
    
    func configureNumberOfProblemsLabel() {
        NSLayoutConstraint.activate([
            numberOfProblemsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            numberOfProblemsLabel.leadingAnchor.constraint(equalTo: animationView.trailingAnchor, constant: 2 * padding),
            numberOfProblemsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
        ])
    }
    
    func configureConfirmLabel() {
        confirmLabel.text = "Practice makes perfect!\nAre you ready?"
        confirmLabel.numberOfLines = 2
        confirmLabel.lineBreakMode = .byWordWrapping
        
        NSLayoutConstraint.activate([
            confirmLabel.topAnchor.constraint(equalTo: numberOfProblemsLabel.bottomAnchor, constant: 2 * padding),
            confirmLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            confirmLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
        ])
    }
    
    func configureDismissButton() {
        dismissButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            dismissButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            dismissButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            dismissButton.widthAnchor.constraint(equalToConstant: containerHalfWidth),
            dismissButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureConfirmButton() {
        confirmButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            confirmButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            confirmButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            confirmButton.widthAnchor.constraint(equalToConstant: containerHalfWidth),
            confirmButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
