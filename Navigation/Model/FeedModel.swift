//
//  FeedModel.swift
//  Navigation
//
//  Created by Максим Донских on 23.12.2022.
//

import Foundation

class FeedModel {
    
    enum FeedModelError: Error {
        case emptyText
        case invalidText
    }
    
    var secretWord = "0"
    
    func check(word: String) -> Bool {
        word == secretWord
    }
    
    func check(word: String, completion: @escaping ((Result<Bool, FeedModelError>) -> Void)) {
        if word == secretWord {
            completion(.success(true))
        } else if word.isEmpty{
            completion(.failure(FeedModelError.emptyText))
        } else if word != secretWord {
            completion(.failure(FeedModelError.invalidText))
        }
    }
}
