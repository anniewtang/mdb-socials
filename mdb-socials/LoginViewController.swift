//
//  ViewController.swift
//  mdb-socials
//
//  Created by Annie Tang on 9/26/17.
//  Copyright © 2017 Annie Tang. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var titleLabel: UILabel!

    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    
    var loginButton: UIButton!
    var signupButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if let _ = user {
                self.performSegue(withIdentifier: "toFeedFromLogin", sender: self)
            } else {
                self.setupTitleLabel()
                self.setupLoginButton()
                self.setupSignupButton()
                self.setupTextFields()
            }
        }
        
//        setupTitleLabel()
//        setupLoginButton()
//        setupSignupButton()
//        setupTextFields()
//        
//        /* FUNC: navigates to Feed with segue, if already signed in */
//        if Auth.auth().currentUser != nil {
//            performSegue(withIdentifier: "toFeedFromLogin", sender: self)
//        }
    }
    
    
    /* UI: "MDB SOCIALS" title label */
    func setupTitleLabel() {
        titleLabel = UILabel(frame:
            CGRect(x: view.frame.width * 0.15,
                   y: view.frame.height * 0.1,
                   width: view.frame.width * 0.7,
                   height: view.frame.height * 0.2))
        titleLabel.text = "MDB\nSOCIALS"
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name:titleLabel.font.fontName, size: 40)
        titleLabel.layer.borderWidth = 2
        titleLabel.layer.borderColor = UIColor.black.cgColor
        view.addSubview(titleLabel)
    }
    
    /* UI: email and password text fields*/
    func setupTextFields() {
        emailTextField = UITextField(frame:
            CGRect(x: view.frame.width * 0.15,
                   y: view.frame.height * 0.45,
                   width: view.frame.width * 0.7,
                   height: view.frame.height * 0.05))
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.placeholder = "Email Address"
        emailTextField.textAlignment = .center
        emailTextField.layoutIfNeeded()
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.masksToBounds = true
        emailTextField.textColor = UIColor.black
        view.addSubview(emailTextField)
        
        
        passwordTextField = UITextField(frame:
            CGRect(x: view.frame.width * 0.15,
                   y: view.frame.height * 0.53,
                   width: view.frame.width * 0.7,
                   height: view.frame.height * 0.05))
        passwordTextField.adjustsFontSizeToFitWidth = true
        passwordTextField.placeholder = "Password"
        passwordTextField.textAlignment = .center
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.masksToBounds = true
        passwordTextField.textColor = UIColor.black
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
    }
    
    /* UI: login button */
    func setupLoginButton() {
        loginButton = UIButton(frame:
            CGRect(x: view.frame.width * 0.15,
                   y: view.frame.height * 0.63,
                   width: view.frame.width * 0.7,
                   height: view.frame.height * 0.06))
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.titleLabel?.font = UIFont(name:"Lato", size: 40)
        loginButton.layer.borderColor = UIColor.black.cgColor
        loginButton.layer.borderWidth = 1
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(selectedLogin), for: .touchUpInside)
    }
    
    /* UI: sign up button */
    func setupSignupButton() {
        signupButton = UIButton(frame:
            CGRect(x: view.frame.width * 0.15,
                   y: view.frame.height * 0.70,
                   width: view.frame.width * 0.7,
                   height: view.frame.height * 0.06))
        signupButton.setTitle("SIGNUP", for: .normal)
        signupButton.setTitleColor(.black, for: .normal)
        signupButton.titleLabel?.font = UIFont(name:"Lato", size: 40)
        signupButton.layer.borderColor = UIColor.black.cgColor
        signupButton.layer.borderWidth = 1
        view.addSubview(signupButton)
        signupButton.addTarget(self, action: #selector(segueToSignup), for: .touchUpInside)
    }
    
    /* FUNC: signs in user with the correct information */
    func selectedLogin(sender: UIButton!) {
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        emailTextField.text = ""
        passwordTextField.text = ""
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error == nil {
                self.performSegue(withIdentifier: "toFeedFromLogin", sender: self)
            }
        }
    }
    
    /* FUNC: segue, toSignupFromLogin */
    func segueToSignup() {
        performSegue(withIdentifier: "toSignupFromLogin", sender: self)
    }

}

