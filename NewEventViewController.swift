//
//  NewSocialViewController.swift
//  mdb-socials
//
//  Created by Annie Tang on 9/26/17.
//  Copyright © 2017 Annie Tang. All rights reserved.
//

import UIKit
import Firebase

/* FUNC: protocol to help dismiss */
protocol NewEventViewControllerProtocol {
    func dismissViewController()
}

class NewEventViewController: UIViewController {
    
    /* FUNCTIONAL */
    var delegate: FeedViewController!
    var currentUser: User?
    
    
    /* UI ELEMENTS */
    var eventName: UITextField!
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
    var imageName: String?
    var imgURL: String?
    
    /* REUSABLE VARIABLES */
    var blue = UIColor(hexString: "#86A2C7")
    var lightGray = UIColor(hexString: "#BFC3C6")
    var gray = UIColor(hexString: "#C1C2C3")
    
    let WIDTH: CGFloat = 244; let X: CGFloat = 66; let HEIGHT: CGFloat = 35
    let OFFSET: CGFloat = 54
    
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
        uploadButton.setTitle("Upload Event Picture from Library", for: .normal)
        uploadButton.setTitleColor(blue, for: .normal)
        uploadButton.layer.borderColor = blue.cgColor
        uploadButton.layer.borderWidth = 3
        uploadButton.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
        view.addSubview(uploadButton)
        view.bringSubview(toFront: uploadButton)
    }
    
    /* FUNC: selecting an image */
    func selectImage(sender: UIButton!) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    /* UI: name, username, email, password text fields & underlines */
    func setupTextFields() {
        let Y: CGFloat = 292
        eventName = UITextField(frame:
            CGRect(x: X,
                   y: Y,
                   w: WIDTH,
                   h: HEIGHT))
        eventName.adjustsFontSizeToFitWidth = true
        eventName.placeholder = "EVENT NAME"
        eventName.textAlignment = .left
        eventName.layoutIfNeeded()
        eventName.layer.masksToBounds = true
        eventName.textColor = gray
        view.addSubview(eventName)
        
        descTextField = UITextField(frame:
            CGRect(x: X,
                   y: Y + OFFSET,
                   w: WIDTH,
                   h: HEIGHT))
        descTextField.adjustsFontSizeToFitWidth = true
        descTextField.placeholder = "EVENT DESCRIPTION"
        descTextField.textAlignment = .left
        descTextField.layoutIfNeeded()
        descTextField.layer.masksToBounds = true
        descTextField.textColor = lightGray
        view.addSubview(descTextField)
        
        datePickerTextField = UITextField(frame:
            CGRect(x: X,
                   y: Y + OFFSET * 2,
                   w: WIDTH,
                   h: HEIGHT))
        datePickerTextField.adjustsFontSizeToFitWidth = true
        datePickerTextField.placeholder = "DATE"
        datePickerTextField.textAlignment = .left
        datePickerTextField.layer.masksToBounds = true
        datePickerTextField.textColor = lightGray
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
                   y: Y + OFFSET,
                   w: WIDTH,
                   h: 1))
        descLineView.layer.borderWidth = 2
        descLineView.layer.borderColor = gray.cgColor
        self.view.addSubview(descLineView)
        
        let dateLineView = UIView(frame:
            CGRect(x: X,
                   y: Y + OFFSET * 2,
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
    
    /* FUNC: done with date picker */
    func doneDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        datePickerTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    /* FUNC: closes and cancels date picker */
    func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    /* UNNEEDED??
    /* UI: setting up text field, event name */
    func setupEventName() {
        eventName = UITextField(frame:
            CGRect(x: view.frame.width * 0.15,
                   y: view.frame.height * 0.2,
                   width: view.frame.width * 0.7,
                   height: view.frame.height * 0.05))
        eventName.adjustsFontSizeToFitWidth = true
        eventName.placeholder = "Event name"
        eventName.textAlignment = .center
        eventName.layoutIfNeeded()
        eventName.layer.borderColor = UIColor.lightGray.cgColor
        eventName.layer.borderWidth = 1.0
        eventName.layer.masksToBounds = true
        eventName.textColor = UIColor.black
        view.addSubview(eventName)
    }
    /* UI: setting up text field, event description */
    func setupdescTextField() {
        descTextField =  UITextField(frame:
            CGRect(x: 10,
                   y: view.frame.height * 0.3,
                   width: UIScreen.main.bounds.width - 20,
                   height: view.frame.height * 0.2))
        descTextField.layoutIfNeeded()
        descTextField.layer.shadowRadius = 2.0
        descTextField.layer.masksToBounds = true
        descTextField.layer.borderColor = UIColor.black.cgColor
        descTextField.layer.borderWidth = 2
        descTextField.placeholder = "Describe your social event!"
        view.addSubview(descTextField)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
     */
    
    
    /* ------------ NAVIGATION & FLOW ------------ */
    
    
    // TODO: CHANGE "FEED" TO "CANCEL"
    /* func setupCancelButton() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(cancelEventCreation(sender:)))
        navigationItem.leftBarButtonItem = cancelButton
    } */
    
    
    /* UI: setting up CREATE button */
    func setupCreateButton() {
        createEventButton = UIButton(frame:
            CGRect(x: X,
                   y: 475,
                   w: WIDTH,
                   h: 41))
        createEventButton.setTitle("Create Event", for: .normal)
        createEventButton.setTitleColor(UIColor.blue, for: .normal)
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
        createEventButton.layer.cornerRadius = 15
        cancelButton.layer.borderColor = blue.cgColor
        cancelButton.layer.masksToBounds = true
        cancelButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        view.addSubview(cancelButton)
    }
    
    /* FUNC: returns to Feed modally */
    func goBack() {
        eventName.text = ""
        datePickerTextField.text = ""
        descTextField.text = ""
        
        self.dismiss(animated: true) {
            self.delegate!.dismissViewController()
        } 
    }
    
    /* FUNC: creating a new Event */
    func addNewEvent(sender: UIButton!) {
        let newEvent = ["eventName": eventName.text ?? "[no title]",
                        "desc": descTextField.text ?? "[no description]",
                        "imageUrl": imgURL as Any,
                        "creator": currentUser?.name ?? "[no user]",
                        "date": datePicker.date.timeIntervalSince1970 ,
                        "numInterested": 0] as [String : Any]
        
        let event = Event(eventDict: newEvent)
        let FeedVC = storyboard?.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        FeedVC.allEvents.append(event)
        goBack()
    }
}
