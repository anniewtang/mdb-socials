//
//  SignupVC+handler.swift
//  mdb-socials
//
//  Created by Annie Tang on 10/1/17.
//  Copyright © 2017 Annie Tang. All rights reserved.
//

import UIKit
import Firebase

extension SignupViewController {
    /* FUNC: creates a user, and puts it into Firebase */
    func signupButtonClicked() {
        let name = nameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil {
                let currentUser = (Auth.auth().currentUser?.uid)!
                let ref = Database.database().reference().child("Users").child(currentUser)
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
        
        dismiss(animated: true, completion: nil)
    }
}
