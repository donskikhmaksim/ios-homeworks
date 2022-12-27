//
//  FeedViewController.swift
//  Navigation
//
//  Created by Максим Донских on 28.10.2022.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {
    
    let feedModel = FeedModel()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var showPostButton: CustomButton = {
        let button = CustomButton(title: "Нажми меня!", width: 250, height: 50, backgroundColor: .systemYellow)
        button.closure = { self.didTapButton() }
        return button
    }()
    
    private lazy var checkGuessButton: CustomButton = {
        let button = CustomButton(title: "Не нажимай!", width: 250, height: 50, backgroundColor: .systemYellow)
        button.closure = {
            self.didTapCheckButton()
            self.hideKeyboard()
        }
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        indicatorLabel.backgroundColor = .white
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didHideKeyboard(_:)),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBrown
        view.addSubview(scrollView)
        scrollView.addSubview(showPostButton)
        scrollView.addSubview(checkGuessButton)
        scrollView.addSubview(textField)
        scrollView.addSubview(indicatorLabel)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Лента"
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            showPostButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showPostButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            checkGuessButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkGuessButton.topAnchor.constraint(equalTo: showPostButton.bottomAnchor, constant: 16),
            
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 16),
            textField.widthAnchor.constraint(equalToConstant: 250),
            textField.heightAnchor.constraint(equalToConstant: 100),
            
            indicatorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            indicatorLabel.widthAnchor.constraint(equalToConstant: 250),
            indicatorLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapButton() {
             let viewController = PostViewController()
             viewController.title = self.firstPost?.author
             self.navigationController?.pushViewController(viewController, animated: true)
         }
    
    @objc private func didTapCheckButton() {
        if textField.text != "" && textField.text != nil {
            self.hideKeyboard()
            if feedModel.check(word: textField.text!) {
                indicatorLabel.backgroundColor = .systemGreen
                self.hideKeyboard()
            } else {
                indicatorLabel.backgroundColor = .systemRed
                self.hideKeyboard()
            }
        } else {
            indicatorLabel.backgroundColor = .white
            self.hideKeyboard()
        }
        self.hideKeyboard()
    }
    
    @objc private func didShowKeyboard(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            print(indicatorLabel.frame.origin.y )
            let indicatorLabelBottomPointY = indicatorLabel.frame.origin.y + indicatorLabel.frame.height
            let keyboardOriginY = view.frame.height - keyboardHeight
            
            let offset = keyboardOriginY <= indicatorLabelBottomPointY
            ? indicatorLabelBottomPointY - keyboardOriginY + 16 + view.safeAreaLayoutGuide.layoutFrame.origin.y
            : 0
            
            scrollView.contentOffset = CGPoint(x: 0, y: offset)
        }
    }
    
    @objc private func didHideKeyboard(_ notification: Notification) {
        hideKeyboard()
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
        self.scrollView.setContentOffset(.zero, animated: true)
    }
    
    let firstPost = posts.first
    
}


