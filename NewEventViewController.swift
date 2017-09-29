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
    
    var delegate: FeedViewController!
    
    var eventsRef: DatabaseReference = Database.database().reference().child("Events")
    var currentUser: User?
    
    var id: String!
    
    var eventName: UITextField!
    var datePickerTextField: UITextField!
    var datePicker: UIDatePicker!
    var descView: UITextField!
    var uploadButton: UIButton!
    
    let picker = UIImagePickerController()
    var eventImageView: UIImageView!
    var imageName: String?
    var imgURL: String?
    
    var createEventButton: UIButton!
    var cancelButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageView()
        setupEventName()
        setupDatePicker()
        setupDescView()
        setupUploadButton()
        
        setupCreateButton()
        setupCancelButton()
    }

    /* ------------ USER INPUT FIELDS ------------ */
    
    /* UI: setting up ImageView and gives a default image */
    func setupImageView() {
        eventImageView = UIImageView(frame:
            CGRect(x: view.frame.width * 0.1,
                   y: view.frame.width * 0.15,
                   width: view.frame.width * 0.4,
                   height: view.frame.width * 0.5))
        eventImageView.contentMode = .scaleAspectFill
        eventImageView.clipsToBounds = true
        view.addSubview(eventImageView)
//        eventImageView.image = #imageLiteral(resourceName: "default")
    }
    
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
    
    /* UI: setting up date picker and toolbar; credits to stack overflow 40484182! */
    func setupDatePicker(){
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        datePickerTextField = UITextField(frame:
            CGRect(x: 10,
                   y: view.frame.height * 0.5,
                   width: UIScreen.main.bounds.width - 20,
                   height: view.frame.height * 0.1))
        datePickerTextField.placeholder = "Event Date"
        view.addSubview(datePickerTextField)
        
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

    /* UI: setting up text field, event description */
    func setupDescView() {
        descView =  UITextField(frame:
            CGRect(x: 10,
                   y: view.frame.height * 0.3,
                   width: UIScreen.main.bounds.width - 20,
                   height: view.frame.height * 0.2))
        descView.layoutIfNeeded()
        descView.layer.shadowRadius = 2.0
        descView.layer.masksToBounds = true
        descView.layer.borderColor = UIColor.black.cgColor
        descView.layer.borderWidth = 2
        descView.placeholder = "Describe your social event!"
        view.addSubview(descView)
    }
    
    /* UI: setting up image picking button */
    func setupUploadButton() {
        uploadButton = UIButton(frame:
            CGRect(x: view.frame.width * 0.1,
                   y: view.frame.height * 0.5,
                   width: view.frame.width * 0.3,
                   height: view.frame.height * 0.05))
        uploadButton.setTitle("Create Event", for: .normal)
        uploadButton.setTitleColor(UIColor.blue, for: .normal)
        uploadButton.layoutIfNeeded()
        uploadButton.layer.borderWidth = 2.0
        uploadButton.layer.cornerRadius = 3.0
        uploadButton.layer.borderColor = UIColor.blue.cgColor
        uploadButton.layer.masksToBounds = true
        uploadButton.addTarget(self, action: #selector(addNewEvent), for: .touchUpInside)
        view.addSubview(uploadButton)
    }
    
    func setupProfileImageView() {
        uploadButton = UIButton(frame: eventImageView.frame)
        uploadButton.setTitle("Upload Event Picture from Library", for: .normal)
        uploadButton.setTitleColor(UIColor.blue, for: .normal)
        uploadButton.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
        view.addSubview(uploadButton)
        view.bringSubview(toFront: uploadButton)
    }
    
    func selectImage(sender: UIButton!) {
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    /* ------------ NAVIGATION & FLOW ------------ */
    
    
    // TODO: CHANGE "FEED" TO "CANCEL"
    /* func setupCancelButton() {
        let cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(cancelEventCreation(sender:)))
        navigationItem.leftBarButtonItem = cancelButton
    } */
    
    /* UI: setting up CREATE button */
    func setupCreateButton() {
        createEventButton = UIButton(frame:
            CGRect(x: view.frame.width * 0.1,
                   y: view.frame.height * 0.5,
                   width: view.frame.width * 0.3,
                   height: view.frame.height * 0.05))
        createEventButton.setTitle("Create Event", for: .normal)
        createEventButton.setTitleColor(UIColor.blue, for: .normal)
        createEventButton.layoutIfNeeded()
        createEventButton.layer.borderWidth = 2.0
        createEventButton.layer.cornerRadius = 3.0
        createEventButton.layer.borderColor = UIColor.blue.cgColor
        createEventButton.layer.masksToBounds = true
        createEventButton.addTarget(self, action: #selector(addNewEvent), for: .touchUpInside)
        view.addSubview(createEventButton)
    }
    
    /* UI: setting up CANCEL button */
    func setupCancelButton() {
        cancelButton = UIButton(frame:
            CGRect(x: view.frame.width * 0.5,
                   y: view.frame.height * 0.5,
                   width: view.frame.width * 0.3,
                   height: view.frame.height * 0.05))
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor.blue, for: .normal)
        cancelButton.layoutIfNeeded()
        cancelButton.layer.borderWidth = 2.0
        cancelButton.layer.cornerRadius = 3.0
        cancelButton.layer.borderColor = UIColor.blue.cgColor
        cancelButton.layer.masksToBounds = true
        cancelButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        view.addSubview(cancelButton)
    }
    
    /* FUNC: returns to Feed modally */
    func goBack(sender: AnyObject) {
        eventName.text = ""
        datePickerTextField.text = ""
        descView.text = ""
        
        self.dismiss(animated: true) {
            self.delegate!.dismissViewController()
        }
    }
    
    /* FUNC: creating a new Event */
    // TODO: EDIT THIS PORTION
    func addNewEvent(sender: UIButton!) {
        /* Things to pass over
         1.) eventName
         2.) desc
         3.) imageUrl
         4.) creator
         5.) date
         6.) numInterested
         */
        let newEvent = ["eventName": eventName.text ?? "[no title]",
                        "desc": descView.text ?? "[no description]",
                        "imageUrl": imgURL as Any,
                        "creator": currentUser?.name,
                        "date": datePicker.date.timeIntervalSince1970,
                        "numInterested": 0] as [String : Any]
        
        let event = Event(eventDict: newEvent)
        let FeedVC = storyboard?.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        FeedVC.allEvents.append(event)
    }
}
