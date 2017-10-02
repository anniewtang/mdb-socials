//
//  LoginVC+Handler.swift
//  mdb-socials
//
//  Created by Annie Tang on 10/1/17.
//  Copyright © 2017 Annie Tang. All rights reserved.
//

import UIKit
import Firebase

extension LoginViewController {
    /* FUNC: present Signup Screen, toSignupFromLogin */
    func segueToSignup() {
        let signupVC = self.storyboard?.instantiateViewController(withIdentifier: String(describing: SignupViewController.self)) as! SignupViewController
        signupVC.delegate = self
        self.present(signupVC, animated: true, completion: nil)
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
            } else {
                let alert = Utils.showAlertForIncompleteFields(warningMessage: error!.localizedDescription)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
