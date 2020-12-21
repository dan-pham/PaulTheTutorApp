//
//  ProblemSetVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/10/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

class ProblemSetVC: UIViewController {
    
    // MARK: - Variables and Constants
    
    var totalProblemsLabel = PTTitleLabel(textAlignment: .center, fontSize: 30, text: "")
    var containerView = PTContainerView(frame: .zero)
    var problemLabel = PTBodyLabel(textAlignment: .right, fontSize: 30)
    var answerTextField = PTTextField(frame: .zero)
//    var encouragementLabel = PTBodyLabel(textAlignment: .center, fontSize: 24)
    var nextButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "Submit")
    var hintButton = PTButton(titleColor: Colors.paulDarkGreen, backgroundColor: .clear, title: "Hint")
    
    var problemSet: ProblemSet!
    var currentProblem = 0
    
    let padding = Padding.standard
    
    
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
        setupNextEquation()
    }
    
    
    // MARK: - Action Functions
    
    @objc func setupNextEquation() {
        if currentProblem != 0 {
            guard let answer = answerTextField.text, !answer.isEmpty else {
                Alerts.showEmptyInputAlert(on: self)
                return
            }
        }
        
        if currentProblem > 0 { checkAnswer() }
        
        guard currentProblem < problemSet.parameters.numberOfProblems else {
            answerTextField.resignFirstResponder()
            presentResultsVC()
            return
        }
        
        currentProblem += 1
        updateFields()
    }
    
    private func checkAnswer() {
        guard let answer = answerTextField.text, !answer.isEmpty else {
            Alerts.showEmptyInputAlert(on: self)
            return
        }
        
        problemSet.problems?[currentProblem - 1].answer = answer
        
        if var problem = problemSet.problems?[currentProblem - 1] {
            problem.isCorrect = answerTextField.text == "\(problem.result)" ? true : false
            problemSet.problems?[currentProblem - 1].isCorrect = problem.isCorrect
        }
    }
    
    @objc func showHint() {
        print("Show hint")
    }
    
    
    // MARK: - Presentation Functions
    
    @objc func presentLeaveConfirmationAlert() {
        Alerts.showLeaveConfirmationAlert(on: self)
    }
    
    private func presentResultsVC() {
        let resultsVC = ResultsVC(problemSet: problemSet)
        resultsVC.resultsDelegate = self
        
        resultsVC.modalPresentationStyle = .overFullScreen
        resultsVC.modalTransitionStyle = .crossDissolve
        present(resultsVC, animated: true)
    }
    
    
    // MARK: - Update UI Functions
    
    private func updateFields() {
        answerTextField.text = ""
        totalProblemsLabel.text = "Question \(currentProblem) of \(problemSet.parameters.numberOfProblems)"
        updateProblemLabel()
//        updateEncouragementLabel()
    }
    
    private func updateProblemLabel() {
        if let problem = problemSet.problems?[currentProblem - 1] {
            problemLabel.text = "\(problem.operand1) \(problem.operation) \(problem.operand2)"
        }
    }
    
//    private func updateEncouragementLabel() {
//        switch currentProblem {
//        case 2:
//            encouragementLabel.text = "You're off to a good start!"
//        case 3, 4:
//            encouragementLabel.text = "Almost halfway!"
//        case 5, 6:
//            encouragementLabel.text = "You're halfway there!"
//        case 7, 8, 9:
//            encouragementLabel.text = "You're almost done!"
//        case 10:
//            encouragementLabel.text = "Last one!"
//            nextButton.setTitle("Finish", for: .normal)
//        default:
//            encouragementLabel.text = "Let's go!"
//        }
//    }
    
}


