//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Максим Донских on 31.12.2022.
//

import Foundation

protocol LoginViewModelProtocol: ViewModelProtocol {
    var onStateDidChange: ((LoginViewModel.State) -> Void)? { get set }
    func updateState(viewInput: LoginViewModel.ViewInput, login: String, password: String)
}

class LoginViewModel: LoginViewModelProtocol {
    
    enum State {
        case initial
        case checking
        case checked(result: Bool)
        case error
    }
    
    enum ViewInput {
        case loginButtonDidTap
    }
    
    weak var coordinator: LoginCoordinator?
    var onStateDidChange: ((State) -> Void)?
    var loginDelegate: LoginViewControllerDelegate?
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    private let loginInspector: LoginInspector
    
    init(loginInspector: LoginInspector) {
        self.loginInspector = loginInspector
    }
    
    func updateState(viewInput: ViewInput, login: String, password: String) {
        switch viewInput {
        case .loginButtonDidTap:
            state = .checking
            let result = loginInspector.check(login: login, pass: password)
            if result {
                self.state = .checked(result: result)
                coordinator?.pushIntoProfileVC(user: userService.user)
            } else {
                self.state = .checked(result: result)
            }
        }
    }
}
