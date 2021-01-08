//
//  ResultsVC+UI.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/11/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit
import Lottie

// MARK: - Configuration Functions

extension ResultsVC {
    
    func configureViewController() {
        view.backgroundColor = Colors.blackOverlay
        view.addSubview(containerView)
    }
    
    func configureContainerView() {
        containerView.addSubviews(scrollView, encouragementLabel, animationView, homeButton)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    func configureHomeButton() {
        homeButton.addTarget(self, action: #selector(homeButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            homeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            homeButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            homeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            homeButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureAnimationView() {
        animationView.animation = Animations.smileAnimation
        animationView.loopMode = .loop
        animationView.play()
        
        let animationViewLength: CGFloat = 50
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            animationView.bottomAnchor.constraint(equalTo: homeButton.topAnchor, constant: -padding),
            animationView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            animationView.widthAnchor.constraint(equalToConstant: animationViewLength),
            animationView.heightAnchor.constraint(equalToConstant: animationViewLength)
        ])
    }
    
    func configureEncouragementLabel() {
        NSLayoutConstraint.activate([
            encouragementLabel.bottomAnchor.constraint(equalTo: animationView.topAnchor, constant: -padding),
            encouragementLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            encouragementLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
        ])
    }
    
    func configureScrollView() {
        scrollView.addSubviews(correctResultsLabel, correctProblemsLabel, incorrectResultsLabel, incorrectProblemsLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            scrollView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            scrollView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            scrollView.bottomAnchor.constraint(equalTo: encouragementLabel.topAnchor, constant: -padding)
        ])
    }
    
    func configureCorrectResultsLabel() {
        NSLayoutConstraint.activate([
            correctResultsLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            correctResultsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            correctResultsLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
    }
    
    func configureCorrectProblemsLabel() {
        correctProblemsLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            correctProblemsLabel.topAnchor.constraint(equalTo: correctResultsLabel.bottomAnchor, constant: padding / 2),
            correctProblemsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            correctProblemsLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
    }
    
    func configureIncorrectResultsLabel() {
        NSLayoutConstraint.activate([
            incorrectResultsLabel.topAnchor.constraint(equalTo: correctProblemsLabel.bottomAnchor, constant: padding),
            incorrectResultsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            incorrectResultsLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
    }
    
    func configureIncorrectProblemsLabel() {
        incorrectProblemsLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            incorrectProblemsLabel.topAnchor.constraint(equalTo: incorrectResultsLabel.bottomAnchor, constant: padding / 2),
            incorrectProblemsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
            incorrectProblemsLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
    }
    
}
