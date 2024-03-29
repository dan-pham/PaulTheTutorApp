//
//  ResultsVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/10/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit
import Lottie

// MARK: - ResultsDelegate Protocol

protocol ResultsDelegate {
    func didSelectHome()
}

class ResultsVC: UIViewController {
    
    // MARK: - Variables and Constants
    
    var resultsDelegate: ResultsDelegate!
    
    let containerView = PTContainerView(frame: .zero)
    lazy var scrollView = PTScrollView(heightConstraint: CGFloat(problemSet.problems!.count * 24 + 104))
    let incorrectResultsLabel = PTTitleLabel(textAlignment: .left, fontSize: 24, text: "")
    let incorrectProblemsLabel = PTBodyLabel(textAlignment: .left, fontSize: 20)
    let correctResultsLabel = PTTitleLabel(textAlignment: .left, fontSize: 24, text: "")
    let correctProblemsLabel = PTBodyLabel(textAlignment: .left, fontSize: 20)
    let encouragementLabel = PTBodyLabel(textAlignment: .center, fontSize: 24)
    let animationView = AnimationView()
    let homeButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "Home")
    
    var problemSet: ProblemSet!
    
    let padding = Padding.standard
    
    var problemsCorrect = 0
    var correctProblems = ""
    var problemsIncorrect = 0
    var incorrectProblems = ""
    
    
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
        calculateResults()
        updateLabels()
        scrollView.flashScrollIndicators()
    }
    
    
    // MARK: - Action Functions
    
    private func calculateResults() {
        for i in 0..<problemSet.parameters.numberOfProblems {
            if problemSet.problems![i].isCorrect {
                if problemsCorrect > 0 { correctProblems.append(contentsOf: "\n") }
                correctProblems.append(contentsOf: "\(problemSet.problems![i].printEquation())")
                problemsCorrect += 1
            } else {
                if problemsIncorrect > 0 { incorrectProblems.append(contentsOf: "\n") }
                incorrectProblems.append(contentsOf: "\(problemSet.problems![i].printEquation())")
                problemsIncorrect += 1
            }
        }
    }
    
    @objc func homeButtonTapped() {
        resultsDelegate.didSelectHome()
    }
    
    
    // MARK: - Update UI Functions
    
    private func configureUI() {
        configureViewController()
        
        configureContainerView()
        configureHomeButton()
        configureAnimationView()
        configureEncouragementLabel()
        
        configureScrollView()
        configureIncorrectResultsLabel()
        configureIncorrectProblemsLabel()
        configureCorrectResultsLabel()
        configureCorrectProblemsLabel()
    }
    
    private func updateLabels() {
        correctResultsLabel.text = "Correct on first try: \(problemsCorrect)/\(problemSet.parameters.numberOfProblems)"
        correctProblemsLabel.text = correctProblems
        incorrectResultsLabel.text = "Incorrect on first try: \(problemsIncorrect)/\(problemSet.parameters.numberOfProblems)"
        incorrectProblemsLabel.text = incorrectProblems
        
        if Double(problemsCorrect) >= Double(problemSet.parameters.numberOfProblems) * 0.7 {
            encouragementLabel.text = "Great job!"
        } else {
            encouragementLabel.numberOfLines = 2
            encouragementLabel.text = "Nice try! Remember, practice makes perfect!"
        }
    }
    
}
