//
//  NewEventVC+handlers.swift
//  mdb-socials
//
//  Created by Annie Tang on 9/29/17.
//  Copyright © 2017 Annie Tang. All rights reserved.
//

import UIKit
import Firebase

extension NewEventViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /* ------------ BUTTON FUNCTIONS ------------ */
    
    /* FUNC: done with date picker */
    func doneDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        datePickerTextField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

    /* FUNC: closes and cancels date picker */
    func cancelDatePicker(){
        self.view.endEditing(true)
    }
    
    /* FUNC: ensures all fields are completed, then adds the Event to Firebase */
    func addNewEvent(sender: UIButton!) {
        if !checkForCompletion() {
            let msg = "Please fill out all the text fields in order to create your event!"
            let alert = Utils.createAlert(warningMessage: msg)
            self.present(alert, animated: true, completion: nil)
        } else {
            sendEventToFirebase()
        }
    }
    
    /* FUNC: creats eventDict & adds the new event to Firebase Database */
    func sendEventToFirebase() {
        /* creating the dict for Firebase */
        let interestedUsers: [String] = [currentUser.id]
        print(eventID)
        let eventDict = ["id": eventID,
                         "imageUrl": imgURL,
                         "eventName": eventNameTextField.text!,
                         "creator": currentUser.name!,
                         "creatorID": currentUser.id!,
                         "desc": descTextField.text!,
                         "date": datePicker.date.timeIntervalSince1970,
                         "numInterested": 0,
                         "interestedUsers": interestedUsers] as [String : Any]
        
        /* create and add the Event object to the tableview */
        let event = Event(eventDict: eventDict)
        event.setupAttributes()
        let FeedVC = storyboard?.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        FeedVC.allEvents.insert(event, at: 0)
        
        /* add event to firebase */
        event.sendToFirebase()
        
        /* return user to the Feed */
        goBackToFeed()
        
    }
    
    /* ------------ APP TRANSITIONS ------------ */
    
    /* FUNC: resets text fields & returns to Feed modally */
    func goBackToFeed() {
        eventNameTextField.text = ""
        datePickerTextField.text = ""
        descTextField.text = ""
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    /* ------------ HELPER FUNCTIONS ------------ */
    
    /* FUNC: returns true if all three text fields have inputs */
    func checkForCompletion() -> Bool {
        return eventNameTextField.hasText && descTextField.hasText && datePickerTextField.hasText
    }

    
    /* ------------ IMAGE PICKING FUNCTIONS ------------ */
    /* FUNC: creates & sets event ID */
    func getEventID() {
        let eventsRef = Database.database().reference().child("Events")
        self.eventID = eventsRef.childByAutoId().key
    }
    
    /* FUNC: sets up picker functionalities */
    func handleSelectEventPicImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }

    /* FUNC: gets & uses image from picker */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let originalImage = info["UIImagePickerControllerOriginalImage"] {
            selectedImageFromPicker = originalImage as? UIImage
        }
        if let selectedImage = selectedImageFromPicker {
            eventImageView.image = selectedImage
            getEventID()
            storeImageToFirebase(eventID: self.eventID, image: eventImageView.image!)
            uploadButton.setTitle("", for: .normal)
            uploadButton.layer.borderColor = UIColor.white.cgColor
            dismiss(animated: true, completion: nil)
        }
    }
    
    /* FUNC: dismisses picker controller */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    /* FUNC: stores event image to FirebaseStorage (using eventID), and saves imgURL */
    func storeImageToFirebase(eventID: String, image: UIImage) {
        let storageRef = Storage.storage().reference().child("EventPics").child(eventID)
        if let uploadData = UIImagePNGRepresentation(image) {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error.debugDescription)
                    return
                }
                if let url = metadata?.downloadURL()?.absoluteString {
                    self.imgURL = url
                }
            }
        }
    }
}
