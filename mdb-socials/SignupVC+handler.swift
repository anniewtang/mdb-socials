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
    /* FUNC: presents popup alert if incomplete text fields */
    func showAlertForIncompleteFields(warningMessage: String) {
        let alert = UIAlertController(title: "WARNING:",
                                      message: warningMessage,
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
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
}
