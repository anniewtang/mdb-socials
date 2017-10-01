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
        
        /* guard statement to ensure all text fields are completed
           else: give an alert popup to inform user they must complete all fields */
        let name = nameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        if name == "" {
            if email == "" || password == "" {
                showAlertForIncompleteFields(warningMessage: "Please fill out the text fields to register for a profile with MDB Socials!")
            }
            showAlertForIncompleteFields(warningMessage: "You must provide a name to register a profile with MDB Socials!")
            return
        }

        Auth.auth().createUser(withEmail: email, password: password, completion:{ (user, error) in
            if error == nil {
                let ref = Database.database().reference()
                let usersRef = ref.child("Users").child((user?.uid)!)
                let userDict = ["name": name, "email": email]
                usersRef.setValue(userDict, withCompletionBlock: { (error, usersRef) in
                    if error != nil {
                        print(error.debugDescription)
                        return
                    }
                })
                self.nameTextField.text = ""
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                
                self.performSegue(withIdentifier: "toFeedFromSignup", sender: self)
            }
            else {
                self.showAlertForIncompleteFields(warningMessage: error!.localizedDescription)
//                print(error.debugDescription)
            }
        })
    }
    
    /* FUNC: presents popup alert if incomplete text fields */
    func showAlertForIncompleteFields(warningMessage: String) {
        let alert = UIAlertController(title: "WARNING:",
                                      message: warningMessage,
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /* FUNC: MODALLY goes back to Login view */
    func backButtonClicked() {
        nameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        
        dismiss(animated: true, completion: nil)
    }
}
