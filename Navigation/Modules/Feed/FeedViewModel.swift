//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Максим Донских on 04.01.2023.
//

import Foundation

protocol FeedViewModelProtocol: ViewModelProtocol {
    func updateState(viewInput: FeedViewModel.ViewInput)
}

class FeedViewModel: FeedViewModelProtocol {
    
    enum State {
        case initial
        case checking
        case checked(result: Bool)
        case error
    }
    
    enum ViewInput {
        case checkButtonDidTap
        case pushButtonDidTap
    }
    
    weak var coordinator: FeedCoordinator?
    var onStateDidChange: ((State) -> Void)?
    var loginDelegate: LoginViewControllerDelegate?
    
    private(set) var state: State = .initial {
        didSet {
            onStateDidChange?(state)
        }
    }
    
    func updateState(viewInput: ViewInput) {
        switch viewInput {
        case .checkButtonDidTap:
            ()
        case .pushButtonDidTap:
            coordinator?.pushPostVC()
        }
    }
}
