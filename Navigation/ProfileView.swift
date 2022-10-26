//
//  ProfileView.swift
//  Navigation
//
//  Created by Максим Донских on 27.10.2022.
//

import UIKit

class ProfileView: UIView {
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var birthDateLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
 
    private func setup() {
        let view = self.loadViewFromXib()
        self.addSubview(view)
        view.frame = self.bounds
    }
    
    private func loadViewFromXib() -> UIView {
        guard let view = Bundle.main.loadNibNamed("ProfileView", owner: self)?.first as? UIView else {
            return UIView()
        }
        
        return view
    }
}
