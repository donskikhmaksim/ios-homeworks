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

    private let login = userService.user.login
    private let pass = "2"
    
    func check(login: String, pass: String) -> Bool {
        if login == self.login && pass == self.pass {
            return true
        } else {
            return false
        }
    }
}
