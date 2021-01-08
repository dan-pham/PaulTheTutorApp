//
//  TabBarVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 1/5/21.
//  Copyright © 2021 Dan Pham. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = Colors.paulDarkGreen
        viewControllers = [createMathFactsMenuNC(), createTimerMenuNC()]
    }
    
    private func createMathFactsMenuNC() -> UINavigationController {
        let mathFactsMenuVC = MathFactsMenuVC()
        mathFactsMenuVC.title = "Math Facts"
        mathFactsMenuVC.tabBarItem = UITabBarItem(title: "Math Facts", image: UIImage(systemName: "plus.slash.minus"), tag: 0)
        
        return UINavigationController(rootViewController: mathFactsMenuVC)
    }
    
    private func createTimerMenuNC() -> UINavigationController {
        let timerMenuVC = TimerMenuVC()
        timerMenuVC.title = "Timer"
        timerMenuVC.tabBarItem = UITabBarItem(title: "Timer", image: UIImage(systemName: "stopwatch"), tag: 1)
        
        return UINavigationController(rootViewController: timerMenuVC)
    }
    
}
