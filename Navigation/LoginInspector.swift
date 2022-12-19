//
//  LoginInspector.swift
//  Navigation
//
//  Created by Максим Донских on 12.12.2022.
//

import Foundation

struct LoginInspector {
    
    let checker = Checker.shared
    
}

extension LoginInspector: LoginViewControllerDelegate {
    
    func check(login: String, pass: String) -> Bool {
        checker.check(login: login, pass: pass)
    }
    
    
}
