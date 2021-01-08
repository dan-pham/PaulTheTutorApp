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
    
    let timerLabel = PTTitleLabel(textAlignment: .center, fontSize: 60, text: "")
    
    let startPauseButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "Start")
    let resetButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "Reset")
    
    let parameters = TimerParameters.shared
    let padding = Padding.standard
    
    var timer = Timer()
    var secondsStarting = 0
    var secondsRemaining = 0
    var isTimerRunning = false
    
    let tenMinutesInSeconds = 600
    let fiveMinutesInSeconds = 300
    let oneMinuteInSeconds = 60
    
    
    init(startingTimeInSeconds: Int) {
        super.init(nibName: nil, bundle: nil)
        secondsStarting = startingTimeInSeconds
        secondsRemaining = secondsStarting
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc func startPause() {
        if isTimerRunning {
            // Pause
            timer.invalidate()
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
        isTimerRunning = true
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func resetTimer() {
        timer.invalidate()
        isTimerRunning = false
        secondsRemaining = secondsStarting
        timerLabel.text = timeString(time: secondsRemaining)
        startPauseButton.setTitle("Start", for: .normal)
        enableStartButton()
    }
    
    @objc func updateTimer() {
        if secondsRemaining > 0 {
            secondsRemaining -= 1
            timerLabel.text = timeString(time: secondsRemaining)
            
            if secondsRemaining == tenMinutesInSeconds || secondsRemaining == fiveMinutesInSeconds || secondsRemaining == oneMinuteInSeconds {
                playAlert()
            }
            
            if secondsRemaining > tenMinutesInSeconds + 5 { secondsRemaining = tenMinutesInSeconds + 5 }
            if secondsRemaining == tenMinutesInSeconds { secondsRemaining = fiveMinutesInSeconds + 5 }
            if secondsRemaining == fiveMinutesInSeconds { secondsRemaining = oneMinuteInSeconds + 5 }
            if secondsRemaining == oneMinuteInSeconds { secondsRemaining = 5 }
            
        } else {
            timer.invalidate()
            startPauseButton.setTitle("Start", for: .normal)
            enableStartButton(false)
            playAlert()
        }
    }
    
    private func enableStartButton(_ isEnabled: Bool = true) {
        startPauseButton.isEnabled = isEnabled
        resetButton.isEnabled = !isEnabled
    }
    
    private func playAlert() {
        AudioServicesPlayAlertSoundWithCompletion(1005, nil)
    }
    
    private func timeString(time: Int) -> String {
        let hours = time / 3600
        let minutes = time / 60 % 60
        let seconds = time % 60
        
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    private func configureUI() {
        view.backgroundColor = Colors.paulLightGreen
        view.addSubviews(timerLabel, startPauseButton, resetButton)
        
        timerLabel.text = timeString(time: secondsRemaining)
        
        startPauseButton.addTarget(self, action: #selector(startPause), for: .touchUpInside)
        
        resetButton.addTarget(self, action: #selector(resetTimer), for: .touchUpInside)
        resetButton.isEnabled = false
        
        NSLayoutConstraint.activate([
            timerLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -Padding.large),
            timerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            timerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            
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
