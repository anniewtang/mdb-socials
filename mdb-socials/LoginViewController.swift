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
            CGRect(x: view.frame.width * 0.15,
                   y: view.frame.height * 0.2,
                   width: view.frame.width * 0.7,
                   height: view.frame.height * 0.3))
        titleLabel.text = "MDB\nSOCIALS"
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name:titleLabel.font.fontName, size: 50)
        titleLabel.layer.borderWidth = 2
        titleLabel.layer.borderColor = UIColor.black.cgColor
        view.addSubview(titleLabel)
    }
    
    func setupLoginButton() {
        loginButton = UIButton(frame:
            CGRect(x: view.frame.width * 0.15,
                   y: view.frame.height * 0.6,
                   width: view.frame.width * 0.7,
                   height: view.frame.height * 0.08))
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.titleLabel?.font = UIFont(name:"Lato", size: 40)
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.borderWidth = 1
        view.addSubview(loginButton)
    }
    
    func setupSignupButton() {
        signupButton = UIButton(frame:
            CGRect(x: view.frame.width * 0.15,
                   y: view.frame.height * 0.73,
                   width: view.frame.width * 0.7,
                   height: view.frame.height * 0.08))
        signupButton.setTitle("SIGNUP", for: .normal)
        signupButton.setTitleColor(.black, for: .normal)
        signupButton.titleLabel?.font = UIFont(name:"Lato", size: 40)
        signupButton.layer.borderColor = UIColor.black.cgColor
        signupButton.layer.borderWidth = 1
        view.addSubview(signupButton)
    }

}

