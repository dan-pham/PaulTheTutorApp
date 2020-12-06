//
//  ConfirmationVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/10/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit
import Lottie

// MARK: - ConfirmationDelegate Protocol

protocol ConfirmationDelegate {
    func didConfirmAction(problemSet: ProblemSet)
    func didCancelAction()
}

class ConfirmationVC: UIViewController {
    
    // MARK: - Variables and Constants
    
    var confirmationDelegate: ConfirmationDelegate!
    
    let containerView = PTContainerView(frame: .zero)
    let animationView = AnimationView()
    let titleLabel = PTTitleLabel(textAlignment: .left, fontSize: 24)
    let numberOfProblemsLabel = PTBodyLabel(textAlignment: .left, fontSize: 20)
    let confirmLabel = PTBodyLabel(textAlignment: .center, fontSize: 24)
    let confirmButton = PTButton(backgroundColor: Colors.paulDarkGreen, title: "Let's go!")
    let dismissButton = PTButton(backgroundColor: Colors.paulDarkGreen, title: "Maybe later")
    
    let padding: CGFloat = 10
    let containerWidth: CGFloat = 300
    var containerHalfWidth: CGFloat = 0
    
    var problemSet: ProblemSet!
    
    
    // MARK: - Initialization Functions
    
    required init(problemSet: ProblemSet) {
        super.init(nibName: nil, bundle: nil)
        self.problemSet = problemSet
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setProblemSet()
    }
    
    
    // MARK: - Action Functions
    
    private func setProblemSet() {
        animationView.animation = problemSet.animation
        animationView.loopMode = .loop
        animationView.play()
        
        titleLabel.text = problemSet.title
        numberOfProblemsLabel.text = "\(problemSet.numberOfProblems) problems"
    }
    
    @objc func confirmAction() {
        confirmationDelegate.didConfirmAction(problemSet: problemSet)
    }
    
    @objc func dismissVC() {
        dismiss(animated: true) {
            self.confirmationDelegate.didCancelAction()
        }
    }
    
    
    // MARK: - Update UI Functions
    
    private func configureUI() {
        configureViewController()
        configureContainerView()
        configureAnimationView()
        configureTitleLabel()
        configureNumberOfProblemsLabel()
        configureConfirmLabel()
        configureDismissButton()
        configureConfirmButton()
    }
    
}
