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
            showAlertForIncompleteFields()
        } else {
            addEventToFirebase()
        }
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
    
    /* FUNC: presents popup alert if incomplete name, desc, or date fields */
    func showAlertForIncompleteFields() {
        let alert = UIAlertController(title: "WARNING: Incomplete Fields",
                                      message: "Please fill out all the text fields in order to create your event!",
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /* ------------ IMAGE PICKING FUNCTIONS ------------ */
    
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
            storeImageToFirebase()
            uploadButton.setTitle("", for: .normal)
            uploadButton.layer.borderColor = UIColor.white.cgColor
            dismiss(animated: true, completion: nil)
        }
    }
    
    /* FUNC: dismisses picker controller */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
