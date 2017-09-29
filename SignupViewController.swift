//
//  ViewController.swift
//  mdb-socials
//
//  Created by Annie Tang on 9/26/17.
//  Copyright © 2017 Annie Tang. All rights reserved.
//

import UIKit
import Firebase

class SignupViewController: UIViewController {
    
    var signupLabel: UILabel!
    
    var nameTextField: UITextField!
    var usernameTextField: UITextField!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    
    var signupButton: UIButton!
    var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitleLabel()
        setupTextFields()
        setupButtons()
    }
    
    /* UI: "SIGNUP" title label */
    func setupTitleLabel() {
        signupLabel = UILabel(frame:
            CGRect(x: view.frame.width * 0.15,
                   y: view.frame.height * 0.1,
                   width: view.frame.width * 0.7,
                   height: view.frame.height * 0.2))
        signupLabel.text = "SIGNUP"
        signupLabel.numberOfLines = 2
        signupLabel.textAlignment = .center
        signupLabel.textColor = .black
        signupLabel.font = UIFont(name:signupLabel.font.fontName, size: 40)
        signupLabel.layer.borderWidth = 2
        signupLabel.layer.borderColor = UIColor.black.cgColor
        view.addSubview(signupLabel)
    }
    
    /* UI: name, username, email, password text fields */
    func setupTextFields() {
        let OFFSET: CGFloat = view.frame.height * 0.065
        let HEIGHT: CGFloat = view.frame.height * 0.45
        
        nameTextField = UITextField(frame:
            CGRect(x: view.frame.width * 0.15,
                   y: HEIGHT,
                   width: view.frame.width * 0.7,
                   height: view.frame.height * 0.05))
        nameTextField.adjustsFontSizeToFitWidth = true
        nameTextField.placeholder = "Full Name"
        nameTextField.textAlignment = .center
        nameTextField.layoutIfNeeded()
        nameTextField.layer.borderColor = UIColor.lightGray.cgColor
        nameTextField.layer.borderWidth = 1.0
        nameTextField.layer.masksToBounds = true
        nameTextField.textColor = UIColor.black
        view.addSubview(nameTextField)
        
        usernameTextField = UITextField(frame:
            CGRect(x: view.frame.width * 0.15,
                   y: HEIGHT + OFFSET,
                   width: view.frame.width * 0.7,
                   height: view.frame.height * 0.05))
        usernameTextField.adjustsFontSizeToFitWidth = true
        usernameTextField.placeholder = "Username"
        usernameTextField.textAlignment = .center
        usernameTextField.layoutIfNeeded()
        usernameTextField.layer.borderColor = UIColor.lightGray.cgColor
        usernameTextField.layer.borderWidth = 1.0
        usernameTextField.layer.masksToBounds = true
        usernameTextField.textColor = UIColor.black
        view.addSubview(usernameTextField)
        
        emailTextField = UITextField(frame:
            CGRect(x: view.frame.width * 0.15,
                   y: HEIGHT + OFFSET * 2,
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
                   y: HEIGHT + OFFSET * 3,
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
    
    /* UI: signup, back buttons! */
    func setupButtons() {
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
        signupButton.addTarget(self, action: #selector(signupButtonClicked), for: .touchUpInside)
        
        backButton = UIButton(frame:
            CGRect(x: 10,
                   y: 0.8 * UIScreen.main.bounds.height + 40,
                   width: UIScreen.main.bounds.width - 20,
                   height: 30))
        backButton.layoutIfNeeded()
        backButton.setTitle("Go Back", for: .normal)
        backButton.setTitleColor(UIColor.blue, for: .normal)
        backButton.layer.borderWidth = 2.0
        backButton.layer.cornerRadius = 3.0
        backButton.layer.borderColor = UIColor.blue.cgColor
        backButton.layer.masksToBounds = true
        backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        self.view.addSubview(backButton)
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
        self.dismiss(animated: true, completion: nil)
    }
    
}

