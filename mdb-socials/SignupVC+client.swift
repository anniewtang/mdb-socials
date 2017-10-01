//
//  SignupVC+client.swift
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
                self.segueToFeed()
            }
            else {
                self.showAlertForIncompleteFields(warningMessage: error!.localizedDescription)
            }
        })
    }
}

