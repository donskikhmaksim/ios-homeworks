//
//  ModalWindowViewController.swift
//  Navigation
//
//  Created by Максим Донских on 28.10.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var alertButton: CustomButton = {
        var button = CustomButton(title: "Кнопка", width: 200, height: 40, backgroundColor: .systemYellow)
        button.closure = { self.didTapButton() }
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBrown
        view.addSubview(alertButton)
        
        NSLayoutConstraint.activate([
            alertButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    @objc private func didTapButton() {
        let alertController = UIAlertController(title: "Заданный титл", message: "Заданное сообщение", preferredStyle: .alert)
        let declineAction = UIAlertAction(title: "Отклонить", style: .default) { _ in
            print("Отклонено")
        }
        let acceptAction = UIAlertAction(title: "Принять", style: .default) { _ in
            print("Принято")
        }
        alertController.addAction(declineAction)
        alertController.addAction(acceptAction)
        self.present(alertController, animated: true)
    }
}
