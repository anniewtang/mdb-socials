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
    var eventImageView: UIImageView!
    
//    var datePicker: UIDatePicker!
    var descView: UITextField!
    
    var createEventButton: UIButton!
    var cancelButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEventName()
//        setupDatePicker()
        showDatePicker()
        setupDescView()
        setupButtons()
    }

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
    
    func setupDatePicker() {
        datePicker = UIDatePicker(frame:
            CGRect(x: 10, y: 400, w: 300, h: 400))
        view.addSubview(datePicker)

    }
    
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
    
    /* setting up button to create a newEvent & send it to Firebase */
    func setupButtons() {
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
    
    func addNewEvent(sender: UIButton!) {
        let key = eventsRef.childByAutoId().key
        let newEvent = ["eventID": key, "desc": descView.text, "creator": currentUser?.name, "imageUrl": currentUser?.imageUrl, "date": datePicker.date, "numInterested": 0] as [String : Any]
        let childUpdates = ["/\(key)/": newEvent]
        eventsRef.updateChildValues(childUpdates)
    }
    
    var txtDatePicker: UITextField!
    var datePicker = UIDatePicker()
    
    func showDatePicker(){
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        txtDatePicker = UITextField(frame:
            CGRect(x: 10,
                   y: view.frame.height * 0.5,
                   width: UIScreen.main.bounds.width - 20,
                   height: view.frame.height * 0.1))
        txtDatePicker.placeholder = "Event Date & Time"
        view.addSubview(txtDatePicker)
        
        //done button & cancel button
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelDatePicker))
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        // add toolbar to textField
        txtDatePicker.inputAccessoryView = toolbar
        // add datepicker to textField
        txtDatePicker.inputView = datePicker
        
    }
    
    func donedatePicker(){
        //For date formate
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.timeStyle = .medium
        txtDatePicker.text = formatter.string(from: datePicker.date)
        //dismiss date picker dialog
        self.view.endEditing(true)
    }
    
    func cancelDatePicker(){
        //cancel button dismiss datepicker dialog
        self.view.endEditing(true)
    }
    
    func goBack(sender: AnyObject) {
        self.dismiss(animated: true) {
            self.delegate!.dismissViewController()
        }
    }

}
