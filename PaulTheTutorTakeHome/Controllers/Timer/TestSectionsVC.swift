//
//  TestSectionsVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 1/5/21.
//  Copyright © 2021 Dan Pham. All rights reserved.
//

import UIKit

class TestSectionsVC: UIViewController {
    
    let testSectionsLabel = PTTitleLabel(textAlignment: .left, fontSize: 20, text: "What sections will you do?")
    let scrollView = PTScrollView(heightConstraint: 450)
    
    let englishButton = PTRadioButton(title: Tests.english.title, isIconSquare: true)
    let mathButton = PTRadioButton(title: Tests.math.title, isIconSquare: true)
    let break1Button = PTRadioButton(title: Tests.testBreak1.title, isIconSquare: true)
    let readingButton = PTRadioButton(title: Tests.reading.title, isIconSquare: true)
    let scienceButton = PTRadioButton(title: Tests.science.title, isIconSquare: true)
    let break2Button = PTRadioButton(title: Tests.testBreak2.title, isIconSquare: true)
    let essayButton = PTRadioButton(title: Tests.essay.title, isIconSquare: true)
    lazy var checkmarkButtons: [PTRadioButton] = [englishButton, mathButton, break1Button, readingButton, scienceButton, break2Button, essayButton]
    
    let startButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "Start")
    
    let parameters = TimerParameters.shared
    let padding = Padding.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setDefaultCheckmarkButtons()
    }
    
    @objc func selectEnglish() {
        handleSelectingButton(englishButton, test: Tests.english)
    }
    
    @objc func selectMath() {
        handleSelectingButton(mathButton, test: Tests.math)
    }
    
    @objc func selectBreak1() {
        handleSelectingButton(break1Button, test: Tests.testBreak1)
    }
    
    @objc func selectReading() {
        handleSelectingButton(readingButton, test: Tests.reading)
    }
    
    @objc func selectScience() {
        handleSelectingButton(scienceButton, test: Tests.science)
    }
    
    @objc func selectBreak2() {
        handleSelectingButton(break2Button, test: Tests.testBreak2)
    }
    
    @objc func selectEssay() {
        handleSelectingButton(essayButton, test: Tests.essay)
    }
    
    @objc func navigateToNextVC() {
        guard !parameters.tests.isEmpty else { return }
        
        let vc = TimerVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setDefaultCheckmarkButtons() {
        for button in checkmarkButtons {
            button.isSelected = true
        }
        
        parameters.tests = [Tests.english, Tests.math, Tests.testBreak1, Tests.reading, Tests.science, Tests.testBreak2, Tests.essay]
    }
    
    private func handleSelectingButton(_ button: PTRadioButton, test: Test) {
        if button.isSelected {
            if !parameters.tests.contains(test) {
                parameters.tests.append(test)
            }
        } else {
            if parameters.tests.contains(test) {
                for (index, parameter) in parameters.tests.enumerated() where parameter == test {
                    parameters.tests.remove(at: index)
                    break
                }
            }
        }
        
        if parameters.tests.isEmpty {
            startButton.isEnabled = false
        } else {
            startButton.isEnabled = true
        }
    }
    
    private func configureUI() {
        view.backgroundColor = Colors.paulLightGreen
        view.addSubviews(testSectionsLabel, scrollView, startButton)
        
        testSectionsLabel.addFlexWidthSetHeightConstraints(to: view)
        
        startButton.addTarget(self, action: #selector(navigateToNextVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        scrollView.addSubviews(englishButton, mathButton, break1Button, readingButton, scienceButton, break2Button, essayButton)
        scrollView.addScrollViewConstraints(to: view, aboveComponent: testSectionsLabel, belowComponent: startButton)
        
        configureCheckmarkButtons()
    }

    private func configureCheckmarkButtons() {
        englishButton.otherButtons = [mathButton, break1Button, readingButton, scienceButton, break2Button, essayButton]
        englishButton.isMultipleSelectionEnabled = true
        
        englishButton.addTarget(self, action: #selector(selectEnglish), for: .touchUpInside)
        mathButton.addTarget(self, action: #selector(selectMath), for: .touchUpInside)
        break1Button.addTarget(self, action: #selector(selectBreak1), for: .touchUpInside)
        readingButton.addTarget(self, action: #selector(selectReading), for: .touchUpInside)
        scienceButton.addTarget(self, action: #selector(selectScience), for: .touchUpInside)
        break2Button.addTarget(self, action: #selector(selectBreak2), for: .touchUpInside)
        essayButton.addTarget(self, action: #selector(selectEssay), for: .touchUpInside)
        
        for button in checkmarkButtons {
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
                button.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding),
                button.heightAnchor.constraint(equalToConstant: 35)
            ])
        }
        
        NSLayoutConstraint.activate([
            englishButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: padding),
            mathButton.topAnchor.constraint(equalTo: englishButton.bottomAnchor, constant: padding),
            break1Button.topAnchor.constraint(equalTo: mathButton.bottomAnchor, constant: padding),
            readingButton.topAnchor.constraint(equalTo: break1Button.bottomAnchor, constant: padding),
            scienceButton.topAnchor.constraint(equalTo: readingButton.bottomAnchor, constant: padding),
            break2Button.topAnchor.constraint(equalTo: scienceButton.bottomAnchor, constant: padding),
            essayButton.topAnchor.constraint(equalTo: break2Button.bottomAnchor, constant: padding),
        ])
    }
    
}
