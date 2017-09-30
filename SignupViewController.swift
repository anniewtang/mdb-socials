//
//  ViewController.swift
//  mdb-socials
//
//  Created by Annie Tang on 9/26/17.
//  Copyright © 2017 Annie Tang. All rights reserved.
//

import UIKit
import Firebase

/* FUNC: protocol to help dismiss */
protocol SignupViewControllerProtocol {
    func dismissViewController()
}

class SignupViewController: UIViewController {
    /* NAVIGATION ELEMENTS */
    var delegate: LoginViewController!
    
    /* UI ELEMENTS */
    var signupTitleLabel: UILabel!
    
    var nameTextField: UITextField!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    
    var signupButton: UIButton!
    var backButton: UIButton!
    
    /* REUSABLE VARIABLES */
    var blue = UIColor(hexString: "#4C9BD0")
    var lightGray = UIColor(hexString: "#BFC3C6")
    let WIDTH: CGFloat = 229.55; let X: CGFloat = 64; let HEIGHT: CGFloat = 35
    let OFFSET: CGFloat = 54
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleLabel()
        setupTextFields()
        setupSignupButton()
        setupBackButton()
    }
    
    /* UI: "SIGNUP" title label */
    func setupTitleLabel() {
        signupTitleLabel = UILabel(frame:
            CGRect(x: 59,
                   y: 175,
                   w: 253,
                   h: 85))
        signupTitleLabel.text = "SIGNUP"
        signupTitleLabel.textAlignment = .center
        signupTitleLabel.textColor = blue
        signupTitleLabel.font = UIFont(name: "HelveticaNeue-BoldItalic", size: 50)
        signupTitleLabel.layer.borderWidth = 2
        signupTitleLabel.layer.borderColor = blue.cgColor
        view.addSubview(signupTitleLabel)
    }
    
    /* UI: name, username, email, password text fields & underlines */
    func setupTextFields() {
        let Y: CGFloat = 292
        nameTextField = UITextField(frame:
            CGRect(x: X,
                   y: Y,
                   w: WIDTH,
                   h: HEIGHT))
        nameTextField.adjustsFontSizeToFitWidth = true
        nameTextField.placeholder = "Full Name"
        nameTextField.textAlignment = .left
        nameTextField.layoutIfNeeded()
        nameTextField.layer.masksToBounds = true
        nameTextField.textColor = lightGray
        view.addSubview(nameTextField)
    
        emailTextField = UITextField(frame:
            CGRect(x: X,
                   y: Y + OFFSET,
                   w: WIDTH,
                   h: HEIGHT))
        emailTextField.adjustsFontSizeToFitWidth = true
        emailTextField.placeholder = "Email Address"
        emailTextField.textAlignment = .left
        emailTextField.layoutIfNeeded()
        emailTextField.layer.masksToBounds = true
        emailTextField.textColor = lightGray
        view.addSubview(emailTextField)
        
        passwordTextField = UITextField(frame:
            CGRect(x: X,
                   y: Y + OFFSET * 2,
                   w: WIDTH,
                   h: HEIGHT))
        passwordTextField.adjustsFontSizeToFitWidth = true
        passwordTextField.placeholder = "Password"
        passwordTextField.textAlignment = .left
        passwordTextField.layer.masksToBounds = true
        passwordTextField.textColor = lightGray
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        
        setupUnderline()
    }
    
    /* UI: setting up the underlines */
    func setupUnderline() {
        let Y: CGFloat = 316.5
        
        let nameLineView = UIView(frame:
            CGRect(x: X,
                   y: Y,
                   w: WIDTH,
                   h: 1))
        nameLineView.layer.borderWidth = 2
        nameLineView.layer.borderColor = UIColor(hexString: "#CACCCE").cgColor
        self.view.addSubview(nameLineView)
        
        let emailLineView = UIView(frame:
            CGRect(x: X,
                   y: Y + OFFSET,
                   w: WIDTH,
                   h: 1))
        emailLineView.layer.borderWidth = 2
        emailLineView.layer.borderColor = UIColor(hexString: "#CACCCE").cgColor
        self.view.addSubview(emailLineView)
        
        let passwordLineView = UIView(frame:
            CGRect(x: X,
                   y: Y + OFFSET * 2,
                   w: WIDTH,
                   h: 1))
        passwordLineView.layer.borderWidth = 2
        passwordLineView.layer.borderColor = UIColor(hexString: "#CACCCE").cgColor
        self.view.addSubview(passwordLineView)
    }
    
    /* UI: signup button */
    func setupSignupButton() {
        signupButton = UIButton(frame:
            CGRect(x: 78,
                   y: 464,
                   w: 239,
                   h: 48))
        signupButton.setTitle("SIGNUP", for: .normal)
        signupButton.setTitleColor(.black, for: .normal)
        signupButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.setTitleColor(.lightGray, for: .selected)
        signupButton.layer.backgroundColor = UIColor(hexString: "#4C9BD0").cgColor
        view.addSubview(signupButton)
        signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
    }
    
    /* UI: setting up BACK button */
    func setupBackButton() {
        backButton = UIButton(frame:
            CGRect(x: 143,
                   y: 521,
                   w: 90,
                   h: 22))
        backButton.setTitle("GO BACK", for: .normal)
        backButton.setTitleColor(UIColor(hexString: "#4C9BD0"), for: .normal)
        backButton.setTitleColor(UIColor(hexString: "#87A9BF"), for: .selected)
        backButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
    }
    
    /* FUNC: creates a user, and puts it into Firebase */
    func signupButtonClicked() {
        let name = nameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil {
                let ref = Database.database().reference().child("Users").child((Auth.auth().currentUser?.uid)!)
                ref.setValue(["name": name, "email": email])
                
                self.nameTextField.text = ""
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                
                self.performSegue(withIdentifier: "toFeedFromSignup", sender: self)
            }
            else {
                print(error.debugDescription)
            }
        }
    }
    
    /* FUNC: MODALLY goes back to Login view */
    func backButtonClicked() {
        nameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        
        self.dismiss(animated: true) {
            self.delegate!.dismissViewController()
        }
    }
    
}

