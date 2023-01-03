//
//  LoginViewController.swift
//  Navigation
//
//  Created by Максим Донских on 31.10.2022.
//

import UIKit

protocol LoginViewControllerDelegate {
    func check(login: String, pass: String) -> Bool
}

class LoginViewController: UIViewController {
    private let viewModel: LoginViewModelProtocol
    
    private lazy var loginView = LoginView(delegate: self)
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.backgroundColor = .systemGray5
        bindViewModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            print(state)
            guard let self = self else {
                return
            }
            switch state {
            case .initial:
                ()
            case .checking:
                self.loginView.updateLoadingIndicator(isLoading: true)
            case .checked(result: true):
                self.loginView.updateLoadingIndicator(isLoading: false)
            case .checked(result: false):
                self.loginView.updateLoadingIndicator(isLoading: false)
            case .error:
                ()
            }
        }
    }
    
    
}


extension LoginViewController : LoginViewDelegate {
    
    @objc func loginButtonDidTap(login: String, password: String) {
        viewModel.updateState(viewInput: .loginButtonDidTap, login: login, password: password)
        
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
        }
    
}

