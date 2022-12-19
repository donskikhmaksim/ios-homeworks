//
//  Checker.swift
//  Navigation
//
//  Created by Максим Донских on 12.12.2022.
//

import Foundation

class Checker {
    static let shared = Checker()
    
    private init() {}
    


    
#if DEBUG
    private let login = testUserService.user.login
#else
    private let login = currentUserService.user.login
#endif
    private let pass = "123"
    
    func check(login: String, pass: String) -> Bool {
        if login == self.login && pass == self.pass {
            return true
        } else {
            return false
        }
    }
}
