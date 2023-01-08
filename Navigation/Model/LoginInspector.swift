//
//  LoginInspector.swift
//  Navigation
//
//  Created by Максим Донских on 12.12.2022.
//

import Foundation

struct LoginInspector {
    let checker = Checker.shared
    
    enum LoginError: Error {
        case invalidLogin
        case invalidPassword
    }
}

extension LoginInspector: LoginViewControllerDelegate {
    func check(login: String, pass: String) throws -> Bool {
        if !checker.check(login: login) {
            throw LoginError.invalidLogin
        } else if !checker.check(password: pass) {
            throw LoginError.invalidPassword
        } else {
            return true
        }
    }
}

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}

struct MyLoginFactory: LoginFactory {
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
