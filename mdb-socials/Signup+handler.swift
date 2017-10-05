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
    
    /* FUNC: resets text fields & segues to Feed */
    func segueToFeed() {
        nameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        
        performSegue(withIdentifier: "toFeedFromSignup", sender: self)
    }
    
    /* FUNC: MODALLY goes back to Login view */
    func backButtonClicked() {
        nameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        
        dismiss(animated: true, completion: nil)
    }

    /* FUNC: creates a user, and puts it into Firebase */
    func signupButtonClicked() {
        let name = nameTextField.text!
        let email = emailTextField.text!
        let password = passwordTextField.text!
        if name == "" {
            var msg = "You must provide a name to register a profile with MDB Socials!"
            if email == "" || password == "" {
                msg = "Please fill out the text fields to register for a profile with MDB Socials!"
            }
            let alert = Utils.createAlert(warningMessage: msg)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion:{ (user, error) in
            if error == nil {
                let ref = Database.database().reference()
                let uid = (user?.uid)!
                let usersRef = ref.child("Users").child(uid)
                let userDict = ["id": uid, "name": name, "email": email] as [String : Any]
                usersRef.setValue(userDict, withCompletionBlock: { (error, usersRef) in
                    if error != nil {
                        print(error.debugDescription)
                        return
                    }
                })
                self.segueToFeed()
            }
            else {
                let alert = Utils.createAlert(warningMessage: error!.localizedDescription)
                self.present(alert, animated: true, completion: nil)
            }
        })
    }


}
