//
//  FeefView.swift
//  Navigation
//
//  Created by Максим Донских on 04.01.2023.
//

import UIKit

protocol FeedViewDelegate: AnyObject {
    func didTapCheckButton()
    func didTapPushButton()
}

class FeedView: UIView {
    
    private weak var delefate: FeedViewDelegate?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var showPostButton: CustomButton = {
        let button = CustomButton(title: "Push", width: 250, height: 50, backgroundColor: .systemYellow)
        button.closure = { self.didTapPushButton() }
        return button
    }()
    
    private lazy var checkGuessButton: CustomButton = {
        let button = CustomButton(title: "Check", width: 250, height: 50, backgroundColor: .systemYellow)
        button.closure = { self.didTapCheckButton() }
        return button
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.textAlignment = .center
        textField.text = "0"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var indicatorLabel: UILabel = {
        let textField = UILabel()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    init(delegate: FeedViewDelegate) {
        super.init(frame: .zero)
        self.delefate = delegate
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .systemBrown
        addSubview(scrollView)
        scrollView.addSubview(showPostButton)
        scrollView.addSubview(checkGuessButton)
        scrollView.addSubview(textField)
        scrollView.addSubview(indicatorLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            showPostButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            showPostButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            checkGuessButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            checkGuessButton.topAnchor.constraint(equalTo: showPostButton.bottomAnchor, constant: 16),
            
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
            textField.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 16),
            textField.widthAnchor.constraint(equalToConstant: 250),
            textField.heightAnchor.constraint(equalToConstant: 100),
            
            indicatorLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            indicatorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            indicatorLabel.widthAnchor.constraint(equalToConstant: 250),
            indicatorLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func didTapCheckButton() {
        delefate?.didTapCheckButton()
    }
    
    func didTapPushButton() {
        delefate?.didTapPushButton()
    }
}


