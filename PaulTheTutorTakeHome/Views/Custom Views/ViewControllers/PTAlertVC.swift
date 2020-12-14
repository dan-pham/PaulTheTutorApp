//
//  PTAlertVC.swift
//  PaulTheTutorTakeHome
//
//  Created by Dan Pham on 5/11/20.
//  Copyright © 2020 Dan Pham. All rights reserved.
//

import UIKit

// MARK: - AlertActionDelegate Protocol

protocol AlertActionDelegate {
    func executeAction()
}

class PTAlertVC: UIViewController {
    
    // MARK: - Variables and Constants
    
    var delegate: AlertActionDelegate!
    
    let containerView = PTContainerView(frame: .zero)
    let titleLabel = PTTitleLabel(textAlignment: .center, fontSize: 24)
    let messageLabel = PTBodyLabel(textAlignment: .center, fontSize: 20)
    let actionButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "Leave")
    let cancelButton = PTButton(titleColor: .white, backgroundColor: Colors.paulDarkGreen, title: "Cancel")
    
    let padding = Padding.standard
    let containerViewWidth: CGFloat = 300
    var isConfirmationAlert = false
    
    
    // MARK: - Initialization Functions
    
    init(title: String, message: String, isConfirmationAlert: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.titleLabel.text = title
        self.messageLabel.text = message
        self.isConfirmationAlert = isConfirmationAlert
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        configureViewController()
        configureContainerView()
        configureTitleLabel()
        configureCancelButton()
        configureMessageLabel()
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
    
    
    // MARK: - PTAlertActionDelegate Functions
    
    @objc func executeAction() {
        delegate.executeAction()
    }
    
}


// MARK: - Configuration Functions

extension PTAlertVC {
    
    private func configureViewController() {
        view.backgroundColor = Colors.blackOverlay
        view.addSubview(containerView)
    }
    
    private func configureContainerView() {
        containerView.addSubviews(titleLabel, cancelButton, messageLabel)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: containerViewWidth),
            containerView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureTitleLabel() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
        ])
    }
    
    private func configureCancelButton() {
        cancelButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        cancelButton.layer.borderColor = UIColor.white.cgColor
        cancelButton.layer.borderWidth = 1
        
        NSLayoutConstraint.activate([
            cancelButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            cancelButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        if isConfirmationAlert {
            let width = (containerViewWidth - 2.5 * padding) / 2
            cancelButton.widthAnchor.constraint(equalToConstant: width).isActive = true
            configureActionButton()
        } else {
            cancelButton.setTitle("OK", for: .normal)
            cancelButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding).isActive = true
        }
    }
    
    private func configureActionButton() {
        containerView.addSubview(actionButton)
        actionButton.addTarget(self, action: #selector(executeAction), for: .touchUpInside)
        
        actionButton.layer.borderColor = UIColor.white.cgColor
        actionButton.layer.borderWidth = 1
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
       
    private func configureMessageLabel() {
        messageLabel.numberOfLines = 2
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -12)
        ])
    }
    
}
