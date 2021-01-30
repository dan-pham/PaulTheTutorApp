//
//  TimerVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 1/5/21.
//  Copyright © 2021 Dan Pham. All rights reserved.
//

import AVFoundation
import UIKit
import UserNotifications


// Alert sound reference: https://github.com/TUNER88/iOSSystemSoundsLibrary
// Background mode reference from https://www.raywenderlich.com/5817-background-modes-tutorial-getting-started#toc-anchor-013


// TODO: Fix background timer to account for pause (add a pauseTimer that counts until resume is tapped, then add the pause time to the background start time?

class TimerVC: UIViewController {
    
    let testLabel = PTTitleLabel(textAlignment: .center, fontSize: 30, text: "")
    let timerLabel = PTTitleLabel(textAlignment: .center, fontSize: 60, text: "")
    
    let startPauseButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "Start")
    let resetButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "Reset")
    
    let parameters = TimerParameters.shared
    let padding = Padding.standard
    
    var currentTest: Test = Tests.english {
        didSet {
            testLabel.text = currentTest.shortTitle
        }
    }
    var currentTestIndex = 0
    
    var timer = Timer()
    var startingTime = 0
    var secondsRemaining = 0
    var isTimerRunning = false
    
    let tenMinutesInSeconds = 600
    let fiveMinutesInSeconds = 300
    let oneMinuteInSeconds = 60
    
    var backgroundTask = UIBackgroundTaskIdentifier.invalid
    var isAppActive = true
    
    let backgroundTimer = BackgroundTimer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handleSettingUpTests()
        configureUI()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, error in
            if let error = error {
                print("Error requesting authorization for local notifications: \(error.localizedDescription)")
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(beginBackgroundTasks), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(checkBackgroundTimer), name: UIApplication.didBecomeActiveNotification, object: nil)
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
            pauseTest()
        } else {
            startTest()
        }
    }
    
    private func startTest() {
        runTimer()
        startPauseButton.setTitle("Pause", for: .normal)
        backgroundTimer.updateNow(withTests: parameters.tests)
    }
    
    private func pauseTest() {
        timer.invalidate()
        isTimerRunning = false
        startPauseButton.setTitle("Resume", for: .normal)
        resetButton.isEnabled = true
        endBackgroundTasks()
    }
    
    private func runTimer() {
        if timer.isValid {
            timer.invalidate()
        }
        
        isTimerRunning = true
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        timer.tolerance = 0.1
    }
    
    private func loadCurrentTests() {
        print("Loading current tests")
        
        let tests = getTestsFromOrderNumbers()
        let remainingTime = getRemainingTime(from: tests)
        getCurrentAndRemainingTests(from: tests, withRemainingTime: remainingTime)
        
        print("Current test: \(currentTest.shortTitle)")
        print("Current test index: \(currentTestIndex)")
        print("Seconds remaining: \(secondsRemaining)")
    }

    private func getTestsFromOrderNumbers() -> [Test] {
        // Sort test order numbers
        backgroundTimer.testOrderNumbers.sort { (test1, test2) -> Bool in
            test1 < test2
        }
        
        // Correlate test order numbers with their respective tests
        var tests: [Test] = []
        
        for number in backgroundTimer.testOrderNumbers {
                 if number == 0 { tests.append(Tests.english) }
            else if number == 1 { tests.append(Tests.math) }
            else if number == 2 { tests.append(Tests.testBreak1) }
            else if number == 3 { tests.append(Tests.reading) }
            else if number == 4 { tests.append(Tests.science) }
            else if number == 5 { tests.append(Tests.testBreak2) }
            else if number == 6 { tests.append(Tests.essay) }
        }
        
        return tests
    }

    private func getRemainingTime(from tests: [Test]) -> Int {
        // Find total testing time
        var totalTestingTime = 0
        for test in tests {
            totalTestingTime += test.duration
        }
        
        // Find remaining testing time
        let now = Date().timeIntervalSince1970
        let timeElapsed = Int(now - backgroundTimer.startTime)
        let remainingTime = totalTestingTime - timeElapsed
        
        print("Total testing time: \(totalTestingTime)")
        print("Elapsed time: \(timeElapsed)")
        print("Remaining time: \(remainingTime)")
        
        return remainingTime
    }

    private func getCurrentAndRemainingTests(from tests: [Test], withRemainingTime remainingTime: Int) {
        let reversedTests = tests.reversed()
        var remainingTime = remainingTime
        var remainingTests: [Test] = []
        
        for (index, test) in reversedTests.enumerated() {
            if test.duration < remainingTime {
                remainingTime -= test.duration
                remainingTests.append(test)
            } else {
                remainingTests.append(test)
                currentTest = test
                secondsRemaining = remainingTime
                currentTestIndex = 6 - index
                break
            }
        }
        
        parameters.tests = remainingTests.reversed()
    }
    
    @objc func resetTimer() {
        timer.invalidate()
        isTimerRunning = false
        secondsRemaining = startingTime
        timerLabel.text = timeString(time: secondsRemaining)
        startPauseButton.setTitle("Start", for: .normal)
        enableStartButton()
        endBackgroundTasks()
        backgroundTimer.clearBackgroundTimer()
    }
    
    @objc func updateTimer() {
        if secondsRemaining > 0 {
            // Timer is running
            secondsRemaining -= 1
            timerLabel.text = timeString(time: secondsRemaining)
            
            if isAppActive && (secondsRemaining == tenMinutesInSeconds || secondsRemaining == fiveMinutesInSeconds || secondsRemaining == oneMinuteInSeconds) {
                playAlert()
            }
            
//            if secondsRemaining > tenMinutesInSeconds + 5 { secondsRemaining = tenMinutesInSeconds + 5 }
//            if secondsRemaining == tenMinutesInSeconds { secondsRemaining = fiveMinutesInSeconds + 5 }
//            if secondsRemaining == fiveMinutesInSeconds || (secondsRemaining == fiveMinutesInSeconds - 5) { secondsRemaining = oneMinuteInSeconds + 5 }
//            if secondsRemaining == oneMinuteInSeconds { secondsRemaining = 5 }
            
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
            endBackgroundTasks()
            backgroundTimer.clearBackgroundTimer()
        }
    }
    
    @objc private func beginBackgroundTasks() {
        guard timer.isValid else { return }
        
        isAppActive = false
        
        backgroundTask = UIApplication.shared.beginBackgroundTask(expirationHandler: { [self] in
            UIApplication.shared.endBackgroundTask(backgroundTask)
            backgroundTask = UIBackgroundTaskIdentifier.invalid
        })
        
        RunLoop.current.add(timer, forMode: .common)
        
        scheduleNotifications()
    }
    
    // Referenced from https://www.hackingwithswift.com/forums/swiftui/running-a-timer-while-the-app-is-in-the-background/1647
    private func scheduleNotifications() {
        var currentTotalTestDuration = 0
        let now = Date()
        var elapsedTime = 0
        
        for (index, test) in parameters.tests.enumerated() where index >= currentTestIndex {  // Look for current test
            elapsedTime = (index == currentTestIndex) ? (currentTest.duration - secondsRemaining) : 0  // Look for time remaining from current test
            
            if (test.duration - elapsedTime > tenMinutesInSeconds) && (test.duration > fiveMinutesInSeconds) {
                let tenMinutesFromEndOfTest = Date(timeIntervalSinceNow: TimeInterval(currentTotalTestDuration + test.duration - elapsedTime - tenMinutesInSeconds)).timeIntervalSince(now)
                addLocalNotification(for: test.shortTitle, withSubtitle: timeString(time: tenMinutesInSeconds), timeInterval: tenMinutesFromEndOfTest)
            }
            
            if (test.duration - elapsedTime > fiveMinutesInSeconds) && (test.duration > fiveMinutesInSeconds) {
                let fiveMinutesFromEndOfTest = Date(timeIntervalSinceNow: TimeInterval(currentTotalTestDuration + test.duration - elapsedTime - fiveMinutesInSeconds)).timeIntervalSince(now)
                addLocalNotification(for: test.shortTitle, withSubtitle: timeString(time: fiveMinutesInSeconds), timeInterval: fiveMinutesFromEndOfTest)
            }
            
            if test.duration - elapsedTime > oneMinuteInSeconds {
                let oneMinuteFromEndOfTest = Date(timeIntervalSinceNow: TimeInterval(currentTotalTestDuration + test.duration - elapsedTime - oneMinuteInSeconds)).timeIntervalSince(now)
                addLocalNotification(for: test.shortTitle, withSubtitle: timeString(time: oneMinuteInSeconds), timeInterval: oneMinuteFromEndOfTest)
            }
            
            if test.duration - elapsedTime > 0 {
                let endOfTest = Date(timeIntervalSinceNow: TimeInterval(currentTotalTestDuration + test.duration - elapsedTime)).timeIntervalSince(now)
                addLocalNotification(for: test.shortTitle, withSubtitle: timeString(time: 0), timeInterval: endOfTest)
            }
            
            currentTotalTestDuration += test.duration
        }
    }
    
    private func addLocalNotification(for title: String, withSubtitle subtitle: String, timeInterval: TimeInterval) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let expectedNotificationTime = dateFormatter.string(from: Date().addingTimeInterval(timeInterval))
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle + ", exp. time: \(expectedNotificationTime)"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = TimerNotification.category.rawValue
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    @objc private func checkBackgroundTimer() {
        print("Did become active, startTime: \(backgroundTimer.startTime), testOrderNumbers: \(backgroundTimer.testOrderNumbers)")
        
        if Int(backgroundTimer.startTime) != 0 && !backgroundTimer.testOrderNumbers.isEmpty {
//            print("Current test found")
            loadCurrentTests()
            startTest()
        } else {
//            print("No current test found")
        }
        
        endBackgroundTasks()
    }
    
    // Referenced from https://medium.com/swlh/background-task-in-swift-a3ac600032ba
    private func endBackgroundTasks() {
        isAppActive = true
        
        if backgroundTask != .invalid {
            UIApplication.shared.endBackgroundTask(backgroundTask)
            backgroundTask = UIBackgroundTaskIdentifier.invalid
        }
        
        removeLocalNotifications()
    }
    
    private func removeLocalNotifications() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    private func enableStartButton(_ isEnabled: Bool = true) {
        startPauseButton.isEnabled = isEnabled
        resetButton.isEnabled = !isEnabled
    }
    
    private func playAlert() {
        AudioServicesPlayAlertSoundWithCompletion(1005, nil)
        
//        print("current test: \(currentTest.shortTitle), time remaining: \(timeString(time: secondsRemaining))")
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
