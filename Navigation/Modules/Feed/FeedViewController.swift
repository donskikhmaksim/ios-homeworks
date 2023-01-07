//
//  FeedViewController.swift
//  Navigation
//
//  Created by Максим Донских on 28.10.2022.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {
    
    let feedModel = FeedModel()
    private var viewModel: FeedViewModelProtocol
    
    private lazy var feedView: FeedView = {
        let view = FeedView(delegate: self)
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = feedView
        bindViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Лента"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    init(viewModel: FeedViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindViewModel() {
        viewModel.onStateDidChange = { [weak self] state in
            guard let self = self else {
                return
            }
            switch state {
            case .initial:
                ()
            case .checking:
                ()
            case .checked(result: true):
                self.feedView.checkText(true)
            case .checked(result: false):
                ()
//                self.feedView.checkText(false)
            case .error(.emptyText):
                self.feedView.whiteLabel()
            case .error(error: .invalidText):
                self.feedView.checkText(false)
            }
        }
    }
    
    @objc func alert() {
        let alert = UIAlertController(title: "Do you want to Login", message: "Please login to continue", preferredStyle: .alert)
        let accept = UIAlertAction(title: "Accept", style: .default) { _ in
            self.navigationController?.pushViewController(LoginViewController(viewModel: LoginViewModel(loginInspector: MyLoginFactory().makeLoginInspector())), animated: true)
        }
        
        let decline = UIAlertAction(title: "Decline", style: .destructive) { _ in
            print("Decline")
        }
        alert.addAction(accept)
        alert.addAction(decline)
        self.navigationController?.present(alert, animated: true)
        
    }
}

extension FeedViewController: FeedViewDelegate {
    
    func didTapCheckButton(text: String) {
        viewModel.updateState(viewInput: .checkButtonDidTap, text: text)
    }
    
    func didTapPushButton() {
        viewModel.updateState(viewInput: .pushButtonDidTap)
    }
}
