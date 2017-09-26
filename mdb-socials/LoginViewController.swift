//
//  ViewController.swift
//  mdb-socials
//
//  Created by Annie Tang on 9/26/17.
//  Copyright © 2017 Annie Tang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var titleLabel: UILabel!
    var loginButton: UIButton!
    var signupButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleLabel()
        setupLoginButton()
        setupSignupButton()
    }
    
    func setupTitleLabel() {
        titleLabel = UILabel(frame:
            CGRect(x: view.frame.width * 0.2,
                   y: view.frame.height * 0.05,
                   width: view.frame.width * 0.7,
                   height: view.frame.height * 0.3))
        titleLabel.text = "MDB SOCIALS"
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name:"Lato", size: 20)
        titleLabel.layer.borderWidth = 1
        titleLabel.layer.borderColor = UIColor.black.cgColor
    }
    
    func setupLoginButton() {
        
    }
    
    func setupSignupButton() {
    
    }

}

