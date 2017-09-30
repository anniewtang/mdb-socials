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

    var mdbTitle: UILabel!
    var socialsTitle: UILabel!
    var iconView: UIImageView!

    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    
    var loginButton: UIButton!
    var signupButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* FUNC: segue if already logged in.
           ELSE: set up icon, title labels, login/sign in buttons, text fields.
         */
        Auth.auth().addStateDidChangeListener { auth, user in
            if let _ = user {
                self.performSegue(withIdentifier: "toFeedFromLogin", sender: self)
            } else {
                self.setupIconView()
                self.setupTitleLabels()
                self.setupTextFields()
                self.setupLoginButton()
                self.setupSignupButton()
            }
        }
    }
    
    /* UI: set up icon */
    func setupIconView() {
        iconView = UIImageView(frame:
            CGRect(x: 22,
                   y: 110,
                   w: 200,
                   h: 200))
        iconView.contentMode = .scaleAspectFill
        iconView.clipsToBounds = true
        view.addSubview(iconView)
        iconView.image = #imageLiteral(resourceName: "mdb")
    }
    
    /* UI: "MDB SOCIALS" title label */
    func setupTitleLabels() {
        mdbTitle = UILabel(frame:
            CGRect(x: 195,
                   y: 161,
                   w: 147,
                   h: 67))
        mdbTitle.text = "MDB"
        mdbTitle.textAlignment = .left
        mdbTitle.textColor = UIColor(hexString: "#4F99CB")
        mdbTitle.font = UIFont(name: "HelveticaNeue", size: 60)
        view.addSubview(mdbTitle)
        
        socialsTitle = UILabel(frame:
            CGRect(x: 195,
                   y: 221,
                   w: 147,
                   h: 38))
        socialsTitle.text = "SOCIALS"
        socialsTitle.textAlignment = .left
        socialsTitle.textColor = UIColor(hexString: "#4F99CB")
        socialsTitle.font = UIFont(name: "HelveticaNeue", size: 30)
        view.addSubview(socialsTitle)
    }
    
    /* UI: email and password text fields*/
    func setupTextFields() {
        emailTextField = UITextField(frame:
            CGRect(x: 78,
                   y: 333,
                   w: 243,
                   h: 28))
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.placeholder = "Email Address"
        emailTextField.textAlignment = .left
        emailTextField.layoutIfNeeded()
        emailTextField.layer.masksToBounds = true
        emailTextField.textColor = UIColor.black
        view.addSubview(emailTextField)
        
        let emailLineView = UIView(frame:
            CGRect(x: 77.5,
                   y: 360.5,
                   w: 243,
                   h: 1))
        emailLineView.layer.borderWidth = 2
        emailLineView.layer.borderColor = UIColor(hexString: "#B2C8D6").cgColor
        self.view.addSubview(emailLineView)
        
        
        passwordTextField = UITextField(frame:
            CGRect(x: 78,
                   y: 390,
                   w: 243,
                   h: 25))
        passwordTextField.adjustsFontSizeToFitWidth = true
        passwordTextField.placeholder = "Password"
        passwordTextField.textAlignment = .left
        passwordTextField.layer.masksToBounds = true
        passwordTextField.textColor = UIColor.black
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        
        let passwordLineView = UIView(frame:
            CGRect(x: 77.5,
                   y: 414.5,
                   w: 243,
                   h: 1))
        passwordLineView.layer.borderWidth = 2
        passwordLineView.layer.borderColor = UIColor(hexString: "#B2C8D6").cgColor
        self.view.addSubview(passwordLineView)
    }
    
    /* UI: login button */
    func setupLoginButton() {
        loginButton = UIButton(frame:
            CGRect(x: 78,
                   y: 464,
                   w: 239,
                   h: 48))
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitleColor(.lightGray, for: .selected)
        loginButton.layer.backgroundColor = UIColor(hexString: "#4C9BD0").cgColor
        view.addSubview(loginButton)
        loginButton.addTarget(self, action: #selector(selectedLogin), for: .touchUpInside)
    }
    
    /* UI: sign up button */
    func setupSignupButton() {
        signupButton = UIButton(frame:
            CGRect(x: 147,
                   y: 521,
                   w: 82,
                   h: 22))
        signupButton.setTitle("SIGNUP", for: .normal)
        signupButton.setTitleColor(UIColor(hexString: "#4C9BD0"), for: .normal)
        signupButton.setTitleColor(UIColor(hexString: "#87A9BF"), for: .selected)
        signupButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
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
//        performSegue(withIdentifier: "toSignupFromLogin", sender: self)
        let signupVC = self.storyboard?.instantiateViewController(withIdentifier: String(describing: SignupViewController.self)) as! SignupViewController
        signupVC.delegate = self
        self.present(signupVC, animated: true, completion: nil)
    }

}

