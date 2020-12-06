//
//  UIHelper.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/10/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

enum UIHelper {
    
    static func createVerticalFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 20
        
        let availableItemWidth = width - (padding * 2)
        let itemHeight: CGFloat = 85
        let minimumItemSpacing: CGFloat = 20
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: availableItemWidth, height: itemHeight)
        flowLayout.minimumInteritemSpacing = minimumItemSpacing
        return flowLayout
    }
    
}
