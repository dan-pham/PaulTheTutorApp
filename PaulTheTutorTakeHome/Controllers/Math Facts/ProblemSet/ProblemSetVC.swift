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
    var remainderTextField = PTTextField(frame: .zero)
    var roundingLabel = PTBodyLabel(textAlignment: .center, fontSize: 20)
//    var encouragementLabel = PTBodyLabel(textAlignment: .center, fontSize: 24)
    var nextButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "Submit")
    var hintButton = PTButton(titleColor: Colors.paulDarkGreen, backgroundColor: .clear, title: "Hint")
    var hintLabel = PTBodyLabel(textAlignment: .left, fontSize: 20)
    
    var problemSet: ProblemSet!
    var currentProblem = 0
    
    var hintTapCount = 0
    
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
            if problemSet.parameters.divisionType == .remainders {
                guard let answer = answerTextField.text, let remainder = remainderTextField.text, !answer.isEmpty, !remainder.isEmpty else {
                    Alerts.showEmptyInputAlert(on: self)
                    return
                }
            }
            
            guard let answer = answerTextField.text, !answer.isEmpty else {
                Alerts.showEmptyInputAlert(on: self)
                return
            }
        }
        
        if currentProblem > 0 { checkAnswer() }
        
        guard currentProblem < problemSet.parameters.numberOfProblems else {
            answerTextField.resignFirstResponder()
            if problemSet.parameters.divisionType == .remainders {
                remainderTextField.resignFirstResponder()
            }
            
            presentResultsVC()
            return
        }
        
        currentProblem += 1
        updateFields()
        updateHint()
        answerTextField.becomeFirstResponder()
    }
    
    private func checkAnswer() {
        if problemSet.parameters.divisionType == .remainders {
            guard let remainder = remainderTextField.text, !remainder.isEmpty else {
                Alerts.showEmptyInputAlert(on: self)
                return
            }
            
            problemSet.problems?[currentProblem - 1].remainderAnswer = remainder
        }
        
        guard let answer = answerTextField.text, !answer.isEmpty else {
            Alerts.showEmptyInputAlert(on: self)
            return
        }
        
        problemSet.problems?[currentProblem - 1].answer = answer
        
        if var problem = problemSet.problems?[currentProblem - 1] {
            if let result = problem.integerResult {
                problem.isCorrect = answerTextField.text == "\(result)" ? true : false
            } else if let quotient = problem.quotient, let remainder = problem.remainder {
                problem.isCorrect = answerTextField.text == "\(quotient)" && remainderTextField.text == "\(remainder)"
            } else if let result = problem.decimalResult?.round(toPlaces: 2), let answer = answerTextField.text, let decimalAnswer = Double(answer)?.round(toPlaces: 2) {
                problem.isCorrect = result == decimalAnswer ? true : false
            }
            
            problemSet.problems?[currentProblem - 1].isCorrect = problem.isCorrect
        }
    }
    
    @objc func showHint() {
        guard hintTapCount < 2, let problem = problemSet.problems?[currentProblem - 1], let result = problem.integerResult, problemSet.parameters.operation == .addition else { return }
        hintTapCount += 1
        
        let hintOperand1 = configureHintOperand1(operand1: problem.operand1, operand2: problem.operand2, result: result)
        let hintOperand2 = configureHintOperand2(hintOperand1: hintOperand1, operand1: problem.operand1, operand2: problem.operand2, result: result)
        
        let problemText = configureProblemText(hintOperand1: hintOperand1, hintOperand2: hintOperand2)
        let answerText = configureAnswerText(hintOperand1: hintOperand1, hintOperand2: hintOperand2)
        
        if hintTapCount == 1 {
            hintLabel.text = problemText
        } else {
            hintLabel.text = problemText + answerText
        }
    }
    
    private func configureHintOperand1(operand1: Int, operand2: Int, result: Int) -> Int {
        let hintOperand1: Int
        
        if (operand1 == operand2) || (result < 10) {
            hintOperand1 = (operand1 > 1) ? (operand1 - 1) : (operand1 + 1)
        } else if (result / 10) > 1 {
            hintOperand1 = result / 10
        } else if result == 10 {
            hintOperand1 = 5
        } else {
            hintOperand1 = 10
        }
        
        return hintOperand1
    }
    
    private func configureHintOperand2(hintOperand1: Int, operand1: Int, operand2: Int, result: Int) -> Int {
        let hintOperand2: Int
        
        if operand1 == operand2 {
            hintOperand2 = hintOperand1
        } else {
            let hintAnswerOffset = 1
            hintOperand2 = result - hintOperand1 - hintAnswerOffset
        }
        
        return hintOperand2
    }
    
    private func configureProblemText(hintOperand1: Int, hintOperand2: Int) -> String {
        let problemText = "\(hintOperand1) + \(hintOperand2)"
        return problemText
    }
    
    private func configureAnswerText(hintOperand1: Int, hintOperand2: Int) -> String {
        let answerText: String
        
        if problemSet.parameters.operation == .addition {
            answerText = " = \(hintOperand1 + hintOperand2)"
        } else {
            answerText = ""
        }
        
        return answerText
    }
    
    private func updateHint() {
        hintTapCount = 0
        hintLabel.text = ""
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
        if problemSet.parameters.divisionType == .remainders {
            remainderTextField.text = ""
        }
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


