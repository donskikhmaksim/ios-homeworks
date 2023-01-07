//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Максим Донских on 04.01.2023.
//

import Foundation

protocol FeedViewModelProtocol: ViewModelProtocol {
    func updateState(viewInput: FeedViewModel.ViewInput, text: String)
    func updateState(viewInput: FeedViewModel.ViewInput)
    var onStateDidChange: ((FeedViewModel.State) -> Void)? { get set }
}

class FeedViewModel: FeedViewModelProtocol {
    
    enum State {
        case initial
        case checking
        case checked(result: Bool)
//        case resultChecked(result: Result<Bool, FeedModel.FeedModelError>)
        case error(error: FeedModel.FeedModelError)
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
    
    func updateState(viewInput: ViewInput, text: String) {
        switch viewInput {
        case .checkButtonDidTap:
            state = .checking
//            let result = FeedModel().check(word: text)
            FeedModel().check(word: text) { result in
                switch result {
                case .success(true):
                    self.state = .checked(result: true)
                case .success(false):
                    ()
                case .failure(.invalidText):
                    print("Invalid text")
                    self.state = .error(error: .invalidText)
                case .failure(.emptyText):
                    print("Empty text")
                    self.state = .error(error: .emptyText)
                }
            }
        case .pushButtonDidTap:
            ()
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
