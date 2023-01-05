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
    
//    @objc private func didTapCheckButton() {
//        if textField.text != "" && textField.text != nil {
//            self.hideKeyboard()
//            if feedModel.check(word: textField.text!) {
//                indicatorLabel.backgroundColor = .systemGreen
//                self.hideKeyboard()
//            } else {
//                indicatorLabel.backgroundColor = .systemRed
//                self.hideKeyboard()
//            }
//        } else {
//            indicatorLabel.backgroundColor = .white
//            self.hideKeyboard()
//        }
//        self.hideKeyboard()
//    }
}

extension FeedViewController: FeedViewDelegate {
    
    func didTapCheckButton() {
        viewModel.updateState(viewInput: .checkButtonDidTap)
    }
    
    func didTapPushButton() {
        viewModel.updateState(viewInput: .pushButtonDidTap)
    }
}
