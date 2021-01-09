//
//  TimerVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 1/5/21.
//  Copyright © 2021 Dan Pham. All rights reserved.
//

import AVFoundation
import UIKit


// Alert sound reference: https://github.com/TUNER88/iOSSystemSoundsLibrary


class TimerVC: UIViewController {
    
    let testLabel = PTTitleLabel(textAlignment: .center, fontSize: 30, text: "")
    let timerLabel = PTTitleLabel(textAlignment: .center, fontSize: 60, text: "")
    
    let startPauseButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "Start")
    let resetButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "Reset")
    
    let parameters = TimerParameters.shared
    let padding = Padding.standard
    
    var currentTest: Test = Tests.english
    var currentTestIndex = 0
    
    var timer = Timer()
    var startingTime = 0
    var secondsRemaining = 0
    var isTimerRunning = false
    
    let tenMinutesInSeconds = 600
    let fiveMinutesInSeconds = 300
    let oneMinuteInSeconds = 60
    
    var bgTask = UIBackgroundTaskIdentifier(rawValue: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleSettingUpTests()
        configureUI()
    }
    
    private func handleSettingUpTests() {
        parameters.tests.sort { (test1, test2) -> Bool in
            test1.orderNumber < test2.orderNumber
        }
        
        if let firstTest = parameters.tests.first {
            currentTest = firstTest
        }
        
        startingTime = currentTest.duration
        secondsRemaining = startingTime
    }
    
    @objc func startPause() {
        if isTimerRunning {
            // Pause
            timer.invalidate()
            UIApplication.shared.endBackgroundTask(bgTask)
            isTimerRunning = false
            startPauseButton.setTitle("Resume", for: .normal)
            resetButton.isEnabled = true
        } else {
            // Play
            runTimer()
            startPauseButton.setTitle("Pause", for: .normal)
        }
    }
    
    private func runTimer() {
        if timer.isValid {
            timer.invalidate()
            UIApplication.shared.endBackgroundTask(bgTask)
        }
        
        isTimerRunning = true
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        bgTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            UIApplication.shared.endBackgroundTask(self.bgTask)
        })
        
        RunLoop.current.add(timer, forMode: .common)
        timer.tolerance = 0.1
    }
    
    @objc func resetTimer() {
        timer.invalidate()
        UIApplication.shared.endBackgroundTask(bgTask)
        isTimerRunning = false
        secondsRemaining = startingTime
        timerLabel.text = timeString(time: secondsRemaining)
        startPauseButton.setTitle("Start", for: .normal)
        enableStartButton()
    }
    
    @objc func updateTimer() {
        if secondsRemaining > 0 {
            // Timer is running
            secondsRemaining -= 1
            timerLabel.text = timeString(time: secondsRemaining)
            
            if secondsRemaining == tenMinutesInSeconds || secondsRemaining == fiveMinutesInSeconds || secondsRemaining == oneMinuteInSeconds {
                playAlert()
            }
            
            if secondsRemaining > tenMinutesInSeconds + 5 { secondsRemaining = tenMinutesInSeconds + 5 }
            if secondsRemaining == tenMinutesInSeconds { secondsRemaining = fiveMinutesInSeconds + 5 }
            if secondsRemaining == fiveMinutesInSeconds || (secondsRemaining == fiveMinutesInSeconds - 5) { secondsRemaining = oneMinuteInSeconds + 5 }
            if secondsRemaining == oneMinuteInSeconds { secondsRemaining = 5 }
            
        } else if currentTestIndex != (parameters.tests.count - 1) {
            // Timer is done running but tests still remain
            playAlert()
            
            currentTestIndex += 1
            currentTest = parameters.tests[currentTestIndex]
            
            startingTime = currentTest.duration
            secondsRemaining = startingTime
            
            testLabel.text = currentTest.shortTitle
            timerLabel.text = timeString(time: secondsRemaining)
        } else {
            // Timer finished naturally
            timer.invalidate()
            startPauseButton.setTitle("Start", for: .normal)
            enableStartButton(false)
            playAlert()
            
            UIApplication.shared.endBackgroundTask(bgTask)
        }
    }
    
    private func enableStartButton(_ isEnabled: Bool = true) {
        startPauseButton.isEnabled = isEnabled
        resetButton.isEnabled = !isEnabled
    }
    
    private func playAlert() {
        print("current test: \(currentTest.shortTitle), time remaining: \(timeString(time: secondsRemaining))")
        
        AudioServicesPlayAlertSoundWithCompletion(1005) { [self] in
            if (currentTestIndex == parameters.tests.count - 1) && (secondsRemaining <= 0) {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
                    UIApplication.shared.endBackgroundTask(bgTask)
                    timer.invalidate()
                }
            }
        }
    }
    
    private func timeString(time: Int) -> String {
        let hours = time / 3600
        let minutes = time / 60 % 60
        let seconds = time % 60
        
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    private func configureUI() {
        view.backgroundColor = Colors.paulLightGreen
        view.addSubviews(testLabel, timerLabel, startPauseButton, resetButton)
        
        testLabel.text = currentTest.shortTitle
        
        timerLabel.text = timeString(time: secondsRemaining)
        
        startPauseButton.addTarget(self, action: #selector(startPause), for: .touchUpInside)
        
        resetButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
        resetButton.isEnabled = false
        
        NSLayoutConstraint.activate([
            timerLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -Padding.large),
            timerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            timerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            
            testLabel.bottomAnchor.constraint(equalTo: timerLabel.topAnchor, constant: -Padding.large),
            testLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            testLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            
            resetButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            resetButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            resetButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            
            startPauseButton.bottomAnchor.constraint(equalTo: resetButton.topAnchor, constant: -padding),
            startPauseButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            startPauseButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            startPauseButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
