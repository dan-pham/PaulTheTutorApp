//
//  DashboardVC+Ext.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/11/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

// MARK: - CollectionView Delegate Functions

extension DashboardVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return problemSets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProblemSetCell.reuseID, for: indexPath) as! ProblemSetCell
        
        cell.setProblemSet(problemSet: problemSets[indexPath.item])
        cell.playAnimation()
        cells.append(cell)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        stopAnimations()
        
        let problemSet = problemSets[indexPath.item]
        let problemSetConfirmationView = ConfirmationVC(problemSet: problemSet)
        problemSetConfirmationView.confirmationDelegate = self
        
        problemSetConfirmationView.modalPresentationStyle = .overFullScreen
        problemSetConfirmationView.modalTransitionStyle = .crossDissolve
        present(problemSetConfirmationView, animated: true)
    }
    
}


// MARK: - ConfirmationDelegate Functions

extension DashboardVC: ConfirmationDelegate {
    
    func didCancelAction() {
        playAnimations()
    }
    
    func didConfirmAction(problemSet: ProblemSet) {
        var problemSet = problemSet
        problemSet.generateProblems()
        
        dismiss(animated: true)
        
        let problemSetVC = ProblemSetVC(problemSet: problemSet)
        navigationController?.pushViewController(problemSetVC, animated: true)
    }
    
}
