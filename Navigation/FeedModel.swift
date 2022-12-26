//
//  FeedModel.swift
//  Navigation
//
//  Created by Максим Донских on 23.12.2022.
//

import Foundation

class FeedModel {
    
    var secretWord = "0"
    
    func check(word: String) -> Bool {
        word == secretWord
    }
}
        if word == secretWord {
            return true
        } else {
            return false
        }
    }
}

let feedModel = FeedModel()
