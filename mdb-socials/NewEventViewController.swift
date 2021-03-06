//
//  NewSocialViewController.swift
//  mdb-socials
//
//  Created by Annie Tang on 9/26/17.
//  Copyright © 2017 Annie Tang. All rights reserved.
//

import UIKit
import Firebase

class NewEventViewController: UIViewController {
    
    /* FUNCTIONAL */
    var currentUser: User!
    var eventID: String!
    
    /* UI ELEMENTS */
    var eventNameTextField: UITextField!
    var datePickerTextField: UITextField!
    var datePicker: UIDatePicker!
    var descTextField: UITextField!

    /* BUTTONS */
    var uploadButton: UIButton!
    var createEventButton: UIButton!
    var cancelButton: UIButton!
    
    /* IMAGE UPLOADING */
    let picker = UIImagePickerController()
    var eventImageView: UIImageView!
    var imgURL: String = "https://i.imgur.com/95BGbRP.png" // default image
    
    /* REUSABLE VARIABLES */
    var blue = UIColor(hexString: "#86A2C7")
    var lightGray = UIColor(hexString: "#BFC3C6")
    var gray = UIColor(hexString: "#C1C2C3")
    let WIDTH: CGFloat = 244; let X: CGFloat = 66 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageView()
        setupUploadButton()
        setupTextFields()
        setupCreateButton()
        setupCancelButton()
    }

    /* ------------ USER INPUT FIELDS ------------ */
    
    /* UI: setting up ImageView */
    func setupImageView() {
        eventImageView = UIImageView(frame:
            CGRect(x: X,
                   y: 117,
                   w: WIDTH,
                   h: 155))
        eventImageView.contentMode = .scaleAspectFill
        eventImageView.clipsToBounds = true
        view.addSubview(eventImageView)
    }
    
    /* UI: setting up uploadButton */
    func setupUploadButton() {
        uploadButton = UIButton(frame: eventImageView.frame)
        uploadButton.setTitle("Upload Event Picture", for: .normal)
        uploadButton.titleLabel?.adjustsFontSizeToFitWidth = true
        uploadButton.setTitleColor(blue, for: .normal)
        uploadButton.layer.borderColor = blue.cgColor
        uploadButton.layer.borderWidth = 3
        uploadButton.addTarget(self, action: #selector(handleSelectEventPicImageView), for: .touchUpInside)
        view.addSubview(uploadButton)
        view.bringSubview(toFront: uploadButton)
    }

    /* UI: name, username, email, password text fields & underlines */
    func setupTextFields() {
        let Y: CGFloat = 292
        eventNameTextField = UITextField(frame:
            CGRect(x: X,
                   y: Y,
                   w: WIDTH,
                   h: Constants.HEIGHT))
        eventNameTextField.adjustsFontSizeToFitWidth = true
        eventNameTextField.attributedPlaceholder = NSAttributedString(string: "EVENT NAME", attributes: [NSForegroundColorAttributeName : gray])
        eventNameTextField.textAlignment = .left
        eventNameTextField.layoutIfNeeded()
        eventNameTextField.layer.masksToBounds = true
        eventNameTextField.textColor = Constants.darkGray
        view.addSubview(eventNameTextField)
        
        descTextField = UITextField(frame:
            CGRect(x: X,
                   y: Y + Constants.OFFSET,
                   w: WIDTH,
                   h: Constants.HEIGHT))
        descTextField.adjustsFontSizeToFitWidth = true
        descTextField.attributedPlaceholder = NSAttributedString(string: "EVENT DESCRIPTION", attributes: [NSForegroundColorAttributeName : gray])
        descTextField.textAlignment = .left
        descTextField.layoutIfNeeded()
        descTextField.layer.masksToBounds = true
        descTextField.textColor = Constants.darkGray
        view.addSubview(descTextField)
        
        datePickerTextField = UITextField(frame:
            CGRect(x: X,
                   y: Y + Constants.OFFSET * 2,
                   w: WIDTH,
                   h: Constants.HEIGHT))
        datePickerTextField.adjustsFontSizeToFitWidth = true
        datePickerTextField.attributedPlaceholder = NSAttributedString(string: "DATE", attributes: [NSForegroundColorAttributeName : gray])
        datePickerTextField.textAlignment = .left
        datePickerTextField.layer.masksToBounds = true
        datePickerTextField.textColor = Constants.darkGray
        view.addSubview(datePickerTextField)
        setupDatePicker()
        
        setupUnderline()
    }
    
    /* UI: setting up the underlines */
    func setupUnderline() {
        let Y: CGFloat = 320
        
        let eventNameLineView = UIView(frame:
            CGRect(x: X,
                   y: Y,
                   w: WIDTH,
                   h: 1))
        eventNameLineView.layer.borderWidth = 2
        eventNameLineView.layer.borderColor = gray.cgColor
        self.view.addSubview(eventNameLineView)
        
        let descLineView = UIView(frame:
            CGRect(x: X,
                   y: Y + Constants.OFFSET,
                   w: WIDTH,
                   h: 1))
        descLineView.layer.borderWidth = 2
        descLineView.layer.borderColor = gray.cgColor
        self.view.addSubview(descLineView)
        
        let dateLineView = UIView(frame:
            CGRect(x: X,
                   y: Y + Constants.OFFSET * 2,
                   w: WIDTH,
                   h: 1))
        dateLineView.layer.borderWidth = 2
        dateLineView.layer.borderColor = gray.cgColor
        self.view.addSubview(dateLineView)
    }

    /* UI: setting up date picker and toolbar; credits to stack overflow 40484182 */
    func setupDatePicker(){
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(doneDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelDatePicker))
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        // add toolbar to textField
        datePickerTextField.inputAccessoryView = toolbar
        // add datepicker to textField
        datePickerTextField.inputView = datePicker
    }

    
    /* ------------ NAVIGATION & FLOW ------------ */
    
    /* UI: setting up CREATE button */
    func setupCreateButton() {
        createEventButton = UIButton(frame:
            CGRect(x: X,
                   y: 475,
                   w: WIDTH,
                   h: 41))
        createEventButton.setTitle("Create Event", for: .normal)
        createEventButton.setTitleColor(.white, for: .normal)
        createEventButton.setTitleColor(lightGray, for: .selected)
        createEventButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        createEventButton.layoutIfNeeded()
        createEventButton.layer.cornerRadius = 15
        createEventButton.layer.backgroundColor = blue.cgColor
        createEventButton.layer.masksToBounds = true
        createEventButton.addTarget(self, action: #selector(addNewEvent), for: .touchUpInside)
        view.addSubview(createEventButton)
    }
    
    /* UI: setting up CANCEL button */
    func setupCancelButton() {
        cancelButton = UIButton(frame:
            CGRect(x: X,
                   y: 528,
                   w: WIDTH,
                   h: 41))
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(blue, for: .normal)
        cancelButton.setTitleColor(lightGray, for: .selected)
        cancelButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 20)
        cancelButton.layoutIfNeeded()
        cancelButton.layer.borderWidth = 2.0
        cancelButton.layer.cornerRadius = 15
        cancelButton.layer.borderColor = blue.cgColor
        cancelButton.layer.masksToBounds = true
        cancelButton.addTarget(self, action: #selector(goBackToFeed), for: .touchUpInside)
        view.addSubview(cancelButton)
    }
}
