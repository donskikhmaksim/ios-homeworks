//
//  User.swift
//  Navigation
//
//  Created by Максим Донских on 07.12.2022.
//

import UIKit

protocol UserServiceProtocol: AnyObject {
    
    func checkLogin(login: String) -> User?
    
}

class User {
    
    var login: String?
    var fullName: String?
    var avatar: UIImage?
    var status: String?
    
    init(login: String, fullName: String, avatar: UIImage?, status: String) {
        self.login = login
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
    
}

class CurrentUserService: UserServiceProtocol {
    
    var user = User(login: "1", fullName: "Donskikh Maksim", avatar: UIImage(named: "crazyFrog"), status: "My status")
    
    func checkLogin(login: String) -> User? {
        if login == user.login {
            return user
        } else {
            return nil
        }
    }
}

class TestUserService: UserServiceProtocol {
    
    var user = User(login: "1", fullName: "Test Test", avatar: UIImage(named: "iceFrog"), status: "Test")
    
    func checkLogin(login: String) -> User? {
        if login == user.login {
            return user
        } else {
            return nil
        }
    }
}

#if DEBUG
let userService = TestUserService()
#else
let userService = CurrentUserService()
#endif
