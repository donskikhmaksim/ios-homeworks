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
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "MyCustomCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosCell")
        tableView.register(ProfileTableHeaderView.self, forHeaderFooterViewReuseIdentifier: "MyCustomHeader")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.backgroundColor = .systemGray5
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupNavigation()
        
    }
    
    private func setupNavigation() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension ProfileViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let defaultCell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        
        if indexPath.section == 0 {
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCell", for: indexPath) as? PhotosTableViewCell else {
            let cell = defaultCell
                cell.selectionStyle = .none
                return cell
            }
            
            cell.selectionStyle = .none
            return cell
        }

        if indexPath.section == 1 {
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath) as? PostTableViewCell else {
                let cell = defaultCell
                cell.selectionStyle = .none
                return cell
                
            }
            
            let viewModel = posts[indexPath.row]
            cell.setup(with: viewModel)
            cell.selectionStyle = .none
            return cell
            
        }
        
        defaultCell.selectionStyle = .none
        return defaultCell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
           return posts.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard
                let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "MyCustomHeader") as? ProfileTableHeaderView else {return nil}
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.someTableView.deselectRow(at: indexPath, animated: true)
        
        if let _ = self.someTableView.cellForRow(at: indexPath) as? PhotosTableViewCell {
            self.navigationController?.pushViewController(PhotosViewController(), animated: true)
        }
    }
}
