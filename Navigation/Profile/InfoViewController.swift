//
//  ModalWindowViewController.swift
//  Navigation
//
//  Created by Максим Донских on 28.10.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    private lazy var alertButton: UIButton = {
        var button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        // Если делаю как предлагаем компилятор, то приложение крашится
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBrown
        self.view.addSubview(alertButton)
        self.alertButton.center = self.view.center
        
    }
    
    @objc private func didTapButton() {
        let alertController = UIAlertController(title: "Заданный титл", message: "Заданное сообщение", preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "Принять", style: .default) { _ in
            print("Принято")
        }
        let declineAction = UIAlertAction(title: "Отклонить", style: .default) { _ in
            print("Отклонено")
        }
        alertController.addAction(acceptAction)
        alertController.addAction(declineAction)
        self.present(alertController, animated: true)
    }
}
