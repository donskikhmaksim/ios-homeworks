//
//  FeedViewController.swift
//  Navigation
//
//  Created by Максим Донских on 28.10.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBrown
        
        
        //        if #available(iOS 15, *) {
        //            let appearance = UINavigationBarAppearance()
        //            appearance.configureWithOpaqueBackground()
        //            self.navigationController?.navigationBar.isTranslucent = true  // pass "true" for fixing iOS 15.0 black bg issue
        //            self.navigationController?.navigationBar.tintColor = UIColor.clear // We need to set tintcolor for iOS 15.0
        //            appearance.shadowColor = .clear    //removing navigationbar 1 px bottom border.
        //            UINavigationBar.appearance().standardAppearance = appearance
        //            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        //
        
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Лента"
    }
}


