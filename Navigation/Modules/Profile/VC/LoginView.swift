//
//  LoginView.swift
//  Navigation
//
//  Created by Максим Донских on 31.12.2022.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func loginButtonDidTap(login: String, password: String)
    
}

class LoginView: UIView {
    
    private weak var delegate: LoginViewDelegate?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "Email or phone"
        textField.text = "1"
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.tintColor = .systemPink
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        textField.indent(size: 12)
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        textField.text = "2"
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.tintColor = .systemPink
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        textField.indent(size: 12)
        return textField
    }()
    
    private lazy var loginButton: CustomButton = {
        let button = CustomButton(title: "Login", titleColor: .white)
        let image = UIImage(named: "blue_pixel")
        let alphaImage = image?.alpha(0.8)
        button.setBackgroundImage(image, for: .normal)
        button.setBackgroundImage(alphaImage, for: .selected)
        button.setBackgroundImage(alphaImage, for: .highlighted)
        button.setBackgroundImage(alphaImage, for: .disabled)
        button.closure = { self.loginButtonDidTap(login: self.loginTextField.text ?? "", password: self.passwordTextField.text ?? "") }
        return button
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .medium
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    init(delegate: LoginViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupView()
        setupGesture()
//        addObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.addSubview(logoImageView)
        scrollView.addSubview(textFieldsStackView)
        scrollView.addSubview(loginButton)
        textFieldsStackView.addArrangedSubview(loginTextField)
        textFieldsStackView.addArrangedSubview(passwordTextField)
        addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            textFieldsStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            textFieldsStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            textFieldsStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            textFieldsStackView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            loginButton.leadingAnchor.constraint(equalTo: textFieldsStackView.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: textFieldsStackView.trailingAnchor),
            loginButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
        
            loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
            
        ])
    }
    
    func updateLoadingIndicator(isLoading: Bool) {
        isLoading ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        addGestureRecognizer(tapGesture)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didHideKeyboard(_:)),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
        
        loginTextField.becomeFirstResponder()
    }
    
    @objc private func didShowKeyboard(_ notification: Notification) {
                if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                    let keyboardRectangle = keyboardFrame.cgRectValue
                    let keyboardHeight = keyboardRectangle.height
        
                    let loginButtonBottomPointY = loginButton.frame.origin.y + loginButton.frame.height
                    let keyboardOriginY = self.frame.height - keyboardHeight
        
                    let offset = keyboardOriginY <= loginButtonBottomPointY
                    ? loginButtonBottomPointY - keyboardOriginY + 16 + safeAreaLayoutGuide.layoutFrame.origin.y
                    : 0
        
                    scrollView.contentOffset = CGPoint(x: 0, y: offset)
                }
    }
    
    @objc private func didHideKeyboard(_ notification: Notification) {
        hideKeyboard()
    }
    
    @objc private func hideKeyboard() {
        endEditing(true)
        scrollView.setContentOffset(.zero, animated: true)
    }
    
    @objc private func loginButtonDidTap(login: String, password: String) {
        delegate?.loginButtonDidTap(login: login, password: password)
//        #if DEBUG
//        let service = testUserService
//        #else
//        let service = currentUserService
//        #endif
//        
//        let alertController = UIAlertController(title: "Error", message: "Incorrect password", preferredStyle: .alert)
//        let wrongPasswordAction = UIAlertAction(title: "Try again?", style: .destructive)
//        alertController.addAction(wrongPasswordAction)
        
//        if (loginDelegate?.check(login: loginTextField.text!, pass: passwordTextField.text!)) ?? false, let user = service.checkLogin(login: loginTextField.text ?? "")  {
//                let vc = ProfileViewController(user: user)
//                self.navigationController?.pushViewController(vc, animated: true)
//            } else {
//            sleep(1)
//            present(alertController, animated: true, completion: nil)
//        }
    }
    
}
