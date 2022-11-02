//
//  LoginViewController.swift
//  Navigation
//
//  Created by Максим Донских on 31.10.2022.
//

import UIKit

extension UIImage {

    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}

extension UITextField {
    func indent(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}
    
let customBlue = UIColor(hex: "#4885CC")

class LoginViewController: UIViewController {
    
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
        textField.text = "Email or phone"
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
        textField.text = "Password"
        textField.backgroundColor = .systemGray6
        textField.textColor = .black
        textField.tintColor = .systemPink
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        textField.indent(size: 12)
        return textField
    }()
        
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "blue_pixel")
        let alphaImage = image?.alpha(0.8)
        button.setBackgroundImage(image, for: .normal)
        button.setBackgroundImage(alphaImage, for: .selected)
        button.setBackgroundImage(alphaImage, for: .highlighted)
        button.setBackgroundImage(alphaImage, for: .disabled)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.backgroundColor = .systemGray5
        self.setupView()
        self.setupGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didHideKeyboard(_:)),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loginTextField.becomeFirstResponder()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(logoImageView)
        self.scrollView.addSubview(textFieldsStackView)
        self.scrollView.addSubview(loginButton)
        self.textFieldsStackView.addArrangedSubview(loginTextField)
        self.textFieldsStackView.addArrangedSubview(passwordTextField)

    
        NSLayoutConstraint.activate([
        self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
        self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        
        self.logoImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 120),
        self.logoImageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
        self.logoImageView.widthAnchor.constraint(equalToConstant: 100),
        self.logoImageView.heightAnchor.constraint(equalToConstant: 100),
        
        self.textFieldsStackView.topAnchor.constraint(equalTo: self.logoImageView.bottomAnchor, constant: 120),
        self.textFieldsStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 16),
        self.textFieldsStackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -16),
        self.textFieldsStackView.widthAnchor.constraint(equalToConstant: self.view.frame.width - 32),
        
        self.loginTextField.heightAnchor.constraint(equalToConstant: 50),
        self.passwordTextField.heightAnchor.constraint(equalToConstant: 50),
        
        self.loginButton.leadingAnchor.constraint(equalTo: self.textFieldsStackView.leadingAnchor),
        self.loginButton.trailingAnchor.constraint(equalTo: self.textFieldsStackView.trailingAnchor),
        self.loginButton.topAnchor.constraint(equalTo: self.textFieldsStackView.bottomAnchor, constant: 16),
        
        self.loginButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didShowKeyboard(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let loginButtonBottomPointY = self.loginButton.frame.origin.y + self.loginButton.frame.height
            let keyboardOriginY = self.view.frame.height - keyboardHeight
            
            let offset = keyboardOriginY <= loginButtonBottomPointY
            ? loginButtonBottomPointY - keyboardOriginY + 16 + self.view.safeAreaLayoutGuide.layoutFrame.origin.y
            : 0
            
            self.scrollView.contentOffset = CGPoint(x: 0, y: offset)
        }
    }
        
    @objc private func didHideKeyboard(_ notification: Notification) {
        self.hideKeyboard()
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
        self.scrollView.setContentOffset(.zero, animated: true)
    }
    
    @objc private func loginButtonDidTap(_ sender: AnyObject) {
        let vc = ProfileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
