//
//  TimerVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 3/10/21.
//  Copyright © 2021 Dan Pham. All rights reserved.
//

import AVFoundation
import UIKit
import UserNotifications

class TimerVC: UIViewController {
    
    let testLabel = PTTitleLabel(textAlignment: .center, fontSize: 30, text: "")
    let timerLabel = PTTitleLabel(textAlignment: .center, fontSize: 60, text: "")
    let startEndButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "")
    
    let parameters = TimerParameters.shared
    let padding = Padding.standard
    
    var tests: [Test] = []
    var currentTest: Test = Tests.english {
        didSet {
            testLabel.text = currentTest.shortTitle
        }
    }
    var currentTestIndex = 0
    
    var timer = Timer()
    var secondsRemaining = 0
    
    let tenMinutesInSeconds = 600
    let fiveMinutesInSeconds = 300
    let oneMinuteInSeconds = 60
    
    let currentTestSession = CurrentTestSession()
    var isContinuing = false
    
    
    required init(isContinuing: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.isContinuing = isContinuing
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isContinuing ? checkCurrentTest() : handleSettingUpTests()
        configureUI()
        if isContinuing { startTest() }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, error in
            if let error = error {
                print("Error requesting authorization for local notifications: \(error.localizedDescription)")
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(getCurrentTest), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    
    // MARK: - Button functions
    
    @objc private func startEndTest() {
        if startEndButton.titleLabel?.text == "Start \(parameters.testType.rawValue)" {
            startTest()
            saveTestInfo()
            scheduleNotifications()
        } else {
            endTest()
            
            if let navigationController = navigationController {
                navigationController.popToRootViewController(animated: true)
            } else {
                dismiss(animated: true)
            }
        }
    }
    
    private func startTest() {
        startEndButton.setTitle("End \(parameters.testType.rawValue)", for: .normal)
        runTimer()
    }
    
    private func endTest() {
        startEndButton.isHidden = true
        timer.invalidate()
        currentTestSession.clearCurrentTestSession()
        removeLocalNotifications()
    }
    
    
    // MARK: - Test functions
    
    private func handleSettingUpTests() {
        parameters.tests.sort { (test1, test2) -> Bool in
            test1.orderNumber < test2.orderNumber
        }
        
        if let firstTest = parameters.tests.first {
            currentTest = firstTest
        }
        
        tests = parameters.tests
        secondsRemaining = currentTest.duration
    }
    
    // SET functions
    
    private func saveTestsToUserDefaults(test: Test, index: Int, endTime: Double) {
        saveTestOrderNumbers(test: test)
        saveTestEndTimes(index: index, endTime: endTime)
    }
    
    private func saveTestInfo() {
        currentTestSession.testType = parameters.testType.rawValue
    }
    
    private func saveTestOrderNumbers(test: Test) {
             if test == Tests.english    { currentTestSession.testOrderNumbers.append(0) }
        else if test == Tests.math       { currentTestSession.testOrderNumbers.append(1) }
        else if test == Tests.testBreak1 { currentTestSession.testOrderNumbers.append(2) }
        else if test == Tests.reading    { currentTestSession.testOrderNumbers.append(3) }
        else if test == Tests.science    { currentTestSession.testOrderNumbers.append(4) }
        else if test == Tests.testBreak2 { currentTestSession.testOrderNumbers.append(5) }
        else if test == Tests.essay      { currentTestSession.testOrderNumbers.append(6) }
    }
    
    private func saveTestEndTimes(index: Int, endTime: Double) {
        let endDate = Date().addingTimeInterval(endTime)
        
             if index == 0 { currentTestSession.firstTestEndTime    = endDate.toString() }
        else if index == 1 { currentTestSession.secondTestEndTime   = endDate.toString() }
        else if index == 2 { currentTestSession.thirdTestEndTime    = endDate.toString() }
        else if index == 3 { currentTestSession.fourthTestEndTime   = endDate.toString() }
        else if index == 4 { currentTestSession.fifthTestEndTime    = endDate.toString() }
        else if index == 5 { currentTestSession.sixthTestEndTime    = endDate.toString() }
        else if index == 6 { currentTestSession.seventhTestEndTime  = endDate.toString() }
    }
    
    // GET functions
    
    private func checkCurrentTest() {
        guard !currentTestSession.testOrderNumbers.isEmpty else {
            handleNoTestSessionFound()
            return
        }
        
//        print("Current test found")
        loadCurrentTestsFromUserDefaults()
        startEndButton.setTitle("End \(parameters.testType.rawValue)", for: .normal)
    }
    
    private func loadCurrentTestsFromUserDefaults() {
//        print("Loading current tests")
        getTestType()
        getTestsFromOrderNumbers()
        getCurrentTest()
        
//        print("Current test: \(currentTest.shortTitle)")
//        print("Seconds remaining: \(secondsRemaining)")
//        print("Tests: \(tests)")
    }
    
    private func getTestType() {
        parameters.testType = (currentTestSession.testType == TimerParameters.TestType.act.rawValue) ? .act : .sat
    }

    private func getTestsFromOrderNumbers() {
        // Sort test order numbers
        currentTestSession.testOrderNumbers.sort { (test1, test2) -> Bool in
            test1 < test2
        }
        
        // Correlate test order numbers with their respective tests
        for number in currentTestSession.testOrderNumbers {
                 if number == 0 { tests.append(Tests.english) }
            else if number == 1 { tests.append(Tests.math) }
            else if number == 2 { tests.append(Tests.testBreak1) }
            else if number == 3 { tests.append(Tests.reading) }
            else if number == 4 { tests.append(Tests.science) }
            else if number == 5 { tests.append(Tests.testBreak2) }
            else if number == 6 { tests.append(Tests.essay) }
        }
    }

    @objc private func getCurrentTest() {
        let now = Date()
        
        if !currentTestSession.firstTestEndTime.isEmpty, let firstTestEndDate = currentTestSession.firstTestEndTime.toDate(), firstTestEndDate > now, tests.count >= 1 {
            updateCurrentTestIndex(to: 0)
            secondsRemaining = Int(firstTestEndDate - now)
        } else if !currentTestSession.secondTestEndTime.isEmpty, let firstTestEndDate = currentTestSession.firstTestEndTime.toDate(), firstTestEndDate < now, let secondTestEndDate = currentTestSession.secondTestEndTime.toDate(), secondTestEndDate > now, tests.count >= 2 {
            updateCurrentTestIndex(to: 1)
            secondsRemaining = Int(secondTestEndDate - now)
        } else if !currentTestSession.thirdTestEndTime.isEmpty, let secondTestEndDate = currentTestSession.secondTestEndTime.toDate(), secondTestEndDate < now, let thirdTestEndDate = currentTestSession.thirdTestEndTime.toDate(), thirdTestEndDate > now, tests.count >= 3 {
            updateCurrentTestIndex(to: 2)
            secondsRemaining = Int(thirdTestEndDate - now)
        } else if !currentTestSession.fourthTestEndTime.isEmpty, let thirdTestEndDate = currentTestSession.thirdTestEndTime.toDate(), thirdTestEndDate < now, let fourthTestEndDate = currentTestSession.fourthTestEndTime.toDate(), fourthTestEndDate > now, tests.count >= 4 {
            updateCurrentTestIndex(to: 3)
            secondsRemaining = Int(fourthTestEndDate - now)
        } else if !currentTestSession.fifthTestEndTime.isEmpty, let fourthTestEndDate = currentTestSession.fourthTestEndTime.toDate(), fourthTestEndDate < now, let fifthTestEndDate = currentTestSession.fifthTestEndTime.toDate(), fifthTestEndDate > now, tests.count >= 5 {
            updateCurrentTestIndex(to: 4)
            secondsRemaining = Int(fifthTestEndDate - now)
        } else if !currentTestSession.sixthTestEndTime.isEmpty, let fifthTestEndDate = currentTestSession.fifthTestEndTime.toDate(), fifthTestEndDate < now, let sixthTestEndDate = currentTestSession.sixthTestEndTime.toDate(), sixthTestEndDate > now, tests.count >= 6 {
            updateCurrentTestIndex(to: 5)
            secondsRemaining = Int(sixthTestEndDate - now)
        } else if !currentTestSession.seventhTestEndTime.isEmpty, let sixthTestEndDate = currentTestSession.sixthTestEndTime.toDate(), sixthTestEndDate < now, let seventhTestEndDate = currentTestSession.seventhTestEndTime.toDate(), seventhTestEndDate > now, tests.count >= 7 {
            updateCurrentTestIndex(to: 6)
            secondsRemaining = Int(seventhTestEndDate - now)
        } else {
            handleNoTestSessionFound()
        }
        
//        print("now: \(now)")
//        print("firstTestEndTime: \(currentTestSession.firstTestEndTime)")
//        print("secondTestEndTime: \(currentTestSession.secondTestEndTime)")
//        print("thirdTestEndTime: \(currentTestSession.thirdTestEndTime)")
//        print("fourthTestEndTime: \(currentTestSession.fourthTestEndTime)")
//        print("fifthTestEndTime: \(currentTestSession.fifthTestEndTime)")
//        print("sixthTestEndTime: \(currentTestSession.sixthTestEndTime)")
//        print("seventhTestEndTime: \(currentTestSession.seventhTestEndTime)")
//        print("secondsRemaining: \(secondsRemaining)")
    }
    
    
    // MARK: - Timer functions
    
    private func runTimer() {
        if timer.isValid {
            timer.invalidate()
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        timer.tolerance = 0.1
    }
    
    @objc private func updateTimer() {
        if secondsRemaining > 0 {
            // Timer is running
            secondsRemaining -= 1
            timerLabel.text = timeString(time: secondsRemaining)
            
            if (secondsRemaining == tenMinutesInSeconds) || (secondsRemaining == fiveMinutesInSeconds) || (secondsRemaining == oneMinuteInSeconds) {
                playAlert()
            }
            
        } else if currentTestIndex <= (tests.count - 1) {
            // Timer is done running but tests still remain
            playAlert()
            
            currentTestIndex += 1
            currentTest = tests[currentTestIndex]
            secondsRemaining = currentTest.duration
            
            testLabel.text = currentTest.shortTitle
            timerLabel.text = timeString(time: secondsRemaining)
        } else {
            // Timer finished naturally
            playAlert()
            endTest()
        }
    }
    
    
    // MARK: - Local Notifications
    
    // Referenced from https://www.hackingwithswift.com/forums/swiftui/running-a-timer-while-the-app-is-in-the-background/1647
    private func scheduleNotifications() {
        var currentTotalTestDuration = 0
        let now = Date()
        
        for (index, test) in parameters.tests.enumerated() where index >= currentTestIndex {
            if test.duration > fiveMinutesInSeconds {
                let tenMinutesFromEndOfTest = Date(timeIntervalSinceNow: TimeInterval(currentTotalTestDuration + test.duration - tenMinutesInSeconds)).timeIntervalSince(now)
                addLocalNotification(for: test.shortTitle, withSubtitle: .tenMinutes, timeInterval: tenMinutesFromEndOfTest)
                
                let fiveMinutesFromEndOfTest = Date(timeIntervalSinceNow: TimeInterval(currentTotalTestDuration + test.duration - fiveMinutesInSeconds)).timeIntervalSince(now)
                addLocalNotification(for: test.shortTitle, withSubtitle: .fiveMinutes, timeInterval: fiveMinutesFromEndOfTest)
            }
            
            let oneMinuteFromEndOfTest = Date(timeIntervalSinceNow: TimeInterval(currentTotalTestDuration + test.duration - oneMinuteInSeconds)).timeIntervalSince(now)
            addLocalNotification(for: test.shortTitle, withSubtitle: .oneMinute, timeInterval: oneMinuteFromEndOfTest)
            
            let isFinalTest = index == parameters.tests.count - 1
            let endTimeOfCurrentTest = Date(timeIntervalSinceNow: TimeInterval(currentTotalTestDuration + test.duration)).timeIntervalSince(now)
            addLocalNotification(for: isFinalTest ? "End of \(parameters.testType.rawValue)" : test.shortTitle, withSubtitle: isFinalTest ? .finalTest : .zeroMinutes, timeInterval: endTimeOfCurrentTest)
            
            saveTestsToUserDefaults(test: test, index: index, endTime: endTimeOfCurrentTest)
            
            currentTotalTestDuration += test.duration
        }
    }
    
    private func addLocalNotification(for title: String, withSubtitle subtitle: TimeRemainingWarnings, timeInterval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle.rawValue
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = TimerNotification.category.rawValue
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
//        print("Adding local notification for title: \(content.title), subtitle: \(content.subtitle), timeInterval: \(timeInterval)")
    }
    
    private func removeLocalNotifications() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    
    // MARK: - Helper Functions
    
    private func updateCurrentTestIndex(to index: Int) {
        currentTest = tests[index]
        currentTestIndex = index
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
    
    private func handleNoTestSessionFound() {
        let alert = UIAlertController(title: "No Test Session Found", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        present(alert, animated: true)
    }
    
    private func configureUI() {
        title = parameters.testType.rawValue
        view.backgroundColor = Colors.paulLightGreen
        view.addSubviews(testLabel, timerLabel, startEndButton)
        
        testLabel.text = currentTest.shortTitle
        timerLabel.text = timeString(time: secondsRemaining)
        
        startEndButton.setTitle("Start \(parameters.testType.rawValue)", for: .normal)
        startEndButton.addTarget(self, action: #selector(startEndTest), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            timerLabel.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -Padding.large),
            timerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            timerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            
            testLabel.bottomAnchor.constraint(equalTo: timerLabel.topAnchor, constant: -Padding.large),
            testLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            testLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            
            startEndButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            startEndButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            startEndButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            startEndButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
