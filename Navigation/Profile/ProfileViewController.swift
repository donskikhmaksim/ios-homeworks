//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Максим Донских on 28.10.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileTableHeaderView: UITableViewHeaderFooterView = {
        let view = UITableViewHeaderFooterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var someTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "My Custom Cell")
        tableView.register(ProfileTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "My Custom Header")
        // зачем нужно, если и без него высота определяется констрейтами?
        // tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Default Cell")
        tableView.backgroundColor = .systemGray5
        // почему без указания высоты, она сама не устанавливается из констрейнтов?
        tableView.sectionHeaderHeight = 210
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupNavigation()
    }
    
    private func setupNavigation() {
        self.navigationController?.isNavigationBarHidden = true
        // не срабатывает
        // self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemGray5

        self.view.addSubview(someTableView)
        
        NSLayoutConstraint.activate([
            self.someTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.someTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.someTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.someTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}

extension ProfileViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "My Custom Cell", for: indexPath) as? PostTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Default Cell", for: indexPath)
            return cell
        }
        
        let viewModel = posts[indexPath.row]
        cell.setup(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "My Custom Header") as? ProfileTableHeaderView else {return nil}
            return headerView
        }
        return nil
    }
}
