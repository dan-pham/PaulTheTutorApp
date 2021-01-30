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
        
        if traitCollection.userInterfaceStyle == .light {
            UITabBar.appearance().tintColor = Colors.paulDarkGreen
        } else {
            UITabBar.appearance().tintColor = Colors.paulLightGreen
        }
        
        viewControllers = [createMathFactsMenuNC(), createTimerMenuNC()]
    }
    
    private func createMathFactsMenuNC() -> UINavigationController {
        // For now since there are only integers, go to OperationsVC
        let mathFactsMenuVC = OperationsVC() // MathFactsMenuVC()
        mathFactsMenuVC.title = "Math Facts"
        mathFactsMenuVC.tabBarItem = UITabBarItem(title: "Math Facts", image: UIImage(systemName: "plus.slash.minus"), tag: 0)
        
        let mathFactsMenuNC = UINavigationController(rootViewController: mathFactsMenuVC)
        mathFactsMenuNC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        mathFactsMenuNC.navigationBar.tintColor = .black
        mathFactsMenuNC.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        return mathFactsMenuNC
    }
    
    private func createTimerMenuNC() -> UINavigationController {
        let timerMenuVC = TimerMenuVC()
        timerMenuVC.title = "Timer"
        timerMenuVC.tabBarItem = UITabBarItem(title: "Timer", image: UIImage(systemName: "stopwatch"), tag: 1)
        
        let timerMenuNC = UINavigationController(rootViewController: timerMenuVC)
        timerMenuNC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        timerMenuNC.navigationBar.tintColor = .black
        timerMenuNC.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        return timerMenuNC
    }
    
}
