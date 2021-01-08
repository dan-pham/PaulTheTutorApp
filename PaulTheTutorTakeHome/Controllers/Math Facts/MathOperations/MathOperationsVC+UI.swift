//
//  MathOperationsVC+UI.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/11/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

// MARK: - Configuration Functions

extension MathOperationsVC {
    
    func configureViewController() {
        view.backgroundColor = Colors.paulLightGreen
    }
    
    func configureNavBar() {
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createVerticalFlowLayout(in: view))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProblemSetCell.self, forCellWithReuseIdentifier: ProblemSetCell.reuseID)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        
        view.addSubview(collectionView)
    }
    
}
