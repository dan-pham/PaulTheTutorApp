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
    
    let englishButton = PTRadioButton(title: "Section 1 [English, 75 questions] - 45 minutes", isIconSquare: true)
    let mathButton = PTRadioButton(title: "Section 2 [Math, 60 questions] - 60 minutes", isIconSquare: true)
    let break1Button = PTRadioButton(title: "Break - 5 minutes", isIconSquare: true)
    let readingButton = PTRadioButton(title: "Section 3 [Reading, 40 questions] - 35 minutes", isIconSquare: true)
    let scienceButton = PTRadioButton(title: "Section 4 [Science, 40 questions] - 35 minutes", isIconSquare: true)
    let break2Button = PTRadioButton(title: "Break 2 (optional) - 5 minutes", isIconSquare: true)
    let essayButton = PTRadioButton(title: "Essay (optional) - 30 minutes", isIconSquare: true)
    lazy var checkmarkButtons: [PTRadioButton] = [englishButton, mathButton, break1Button, readingButton, scienceButton, break2Button, essayButton]
    
    let nextButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "Next")
    
    let parameters = TimerParameters.shared
    let padding = Padding.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setDefaultCheckmarkButtons()
    }
    
    @objc func selectEnglish() {
        handleSelectingButton(englishButton, section: .english)
    }
    
    @objc func selectMath() {
        handleSelectingButton(mathButton, section: .math)
    }
    
    @objc func selectBreak1() {
        handleSelectingButton(break1Button, section: .break1)
    }
    
    @objc func selectReading() {
        handleSelectingButton(readingButton, section: .reading)
    }
    
    @objc func selectScience() {
        handleSelectingButton(scienceButton, section: .science)
    }
    
    @objc func selectBreak2() {
        handleSelectingButton(break2Button, section: .break2)
    }
    
    @objc func selectEssay() {
        handleSelectingButton(essayButton, section: .essay)
    }
    
    @objc func navigateToNextVC() {
        let vc = TimerVC(startingTimeInSeconds: 18000)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setDefaultCheckmarkButtons() {
        for button in checkmarkButtons {
            button.isSelected = true
        }
        
        parameters.testSections = [.english, .math, .break1, .reading, .science, .break2, .essay]
    }
    
    private func handleSelectingButton(_ button: PTRadioButton, section: TimerParameters.TestSection) {
        if button.isSelected {
            if !parameters.testSections.contains(section) {
                parameters.testSections.append(section)
            }
        } else {
            if parameters.testSections.contains(section) {
                for (index, parameter) in parameters.testSections.enumerated() where parameter == section {
                    parameters.testSections.remove(at: index)
                    break
                }
            }
        }
    }
    
    private func configureUI() {
        view.backgroundColor = Colors.paulLightGreen
        view.addSubviews(testSectionsLabel, scrollView, nextButton)
        
        testSectionsLabel.addFlexWidthSetHeightConstraints(to: view)
        
        nextButton.addTarget(self, action: #selector(navigateToNextVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        scrollView.addSubviews(englishButton, mathButton, break1Button, readingButton, scienceButton, break2Button, essayButton)
        scrollView.addScrollViewConstraints(to: view, aboveComponent: testSectionsLabel, belowComponent: nextButton)
        
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
