//
//  ProblemSetCell.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/10/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit
import Lottie

class ProblemSetCell: UICollectionViewCell {
    
    // MARK: - Variables and Constants
    
    static let reuseID = "ProblemSetCell"
    
    let animationView = AnimationView()
    let titleLabel = PTTitleLabel(textAlignment: .left, fontSize: 24)
    let numberOfProblemsLabel = PTBodyLabel(textAlignment: .left, fontSize: 20)
    let chevronImageView = PTImageView(frame: .zero)
    
    
    // MARK: - Initialization Functions
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public Functions
    
    func setProblemSet(problemSet: ProblemSet) {
        titleLabel.text = problemSet.title
        numberOfProblemsLabel.text = "\(problemSet.numberOfProblems) problems"
        
        animationView.animation = problemSet.animation
    }
    
    func playAnimation() {
        animationView.play()
    }
    
    func stopAnimation() {
        animationView.stop()
    }
    
    
    // MARK: - Configuration Functions
    
    private func configure() {
        addSubviews(animationView, chevronImageView, titleLabel, numberOfProblemsLabel)
        
        backgroundColor = .white
        layer.cornerRadius = 10
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowRadius = 10
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        
        chevronImageView.image = SFSymbols.chevronRight
        chevronImageView.tintColor = Colors.paulDarkGreen
        
        let padding: CGFloat = 10
        let iconImageViewLength: CGFloat = 50
        let chevronImageViewLength: CGFloat = 30
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = .loop
        
        NSLayoutConstraint.activate([
            animationView.centerYAnchor.constraint(equalTo: centerYAnchor),
            animationView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            animationView.widthAnchor.constraint(equalToConstant: iconImageViewLength),
            animationView.heightAnchor.constraint(equalToConstant: iconImageViewLength),
            
            chevronImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            chevronImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            chevronImageView.widthAnchor.constraint(equalToConstant: chevronImageViewLength),
            chevronImageView.heightAnchor.constraint(equalToConstant: chevronImageViewLength),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: animationView.trailingAnchor, constant: 2 * padding),
            titleLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -padding),
            
            numberOfProblemsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            numberOfProblemsLabel.leadingAnchor.constraint(equalTo: animationView.trailingAnchor, constant: 2 * padding),
            numberOfProblemsLabel.trailingAnchor.constraint(equalTo: chevronImageView.leadingAnchor, constant: -padding)
        ])
    }
    
}
