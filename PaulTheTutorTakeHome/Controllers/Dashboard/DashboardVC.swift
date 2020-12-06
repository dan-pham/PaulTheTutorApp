//
//  DashboardVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/10/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

class DashboardVC: UIViewController {
    
    // MARK: - Variables and Constants
    
    var collectionView: UICollectionView!
    
    var problemSets: [ProblemSet] = []
    var cells: [ProblemSetCell] = []
    
    
    // MARK: - View Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupProblemSets()
    }
    
    
    // MARK: - Action Functions
    
    private func setupProblemSets() {
        let additionProblemSet: ProblemSet = ProblemSet(title: "Addition", animation: Animations.plusAnimation!, numberOfProblems: 10, operation: "+")
        let subtractionProblemSet: ProblemSet = ProblemSet(title: "Subtraction", animation: Animations.minusAnimation!, numberOfProblems: 10, operation: "-")
        
        problemSets = [additionProblemSet, subtractionProblemSet]
    }
    
    func playAnimations() {
        for cell in cells {
            cell.playAnimation()
        }
    }
    
    func stopAnimations() {
        for cell in cells {
            cell.stopAnimation()
        }
    }
    
    
    // MARK: - Update UI Functions
    
    private func configureUI() {
        configureViewController()
        configureNavBar()
        configureCollectionView()
    }
    
}


