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
    
    @objc func alert() {
        let alert = UIAlertController(title: "Do you want to Login", message: "Please login to continue", preferredStyle: .alert)
        let accept = UIAlertAction(title: "Accept", style: .default) { _ in
            self.navigationController?.pushViewController(LoginViewController(viewModel: LoginViewModel(loginInspector: MyLoginFactory().makeLoginInspector())), animated: true)
        }
        
        let decline = UIAlertAction(title: "Decline", style: .destructive) { _ in
            exit(1)
        }
        alert.addAction(accept)
        alert.addAction(decline)
        self.navigationController?.present(alert, animated: true)
        
    }
}

extension FeedViewController: FeedViewDelegate {
    
    func didTapCheckButton() {
        viewModel.updateState(viewInput: .checkButtonDidTap)
    }
    
    func didTapPushButton() {
        viewModel.updateState(viewInput: .pushButtonDidTap)
    }
}
