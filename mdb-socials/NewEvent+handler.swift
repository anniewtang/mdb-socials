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
    
    /* FUNC: resets text fields & returns to Feed modally */
    func goBackToFeed() {
        eventName.text = ""
        datePickerTextField.text = ""
        descTextField.text = ""
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    /* FUNC: returns true if all three text fields have inputs */
    func checkForCompletion() -> Bool {
        return eventName.hasText && descTextField.hasText && datePickerTextField.hasText
    }
    
    /* FUNC: presents popup alert if incomplete name, desc, or date fields */
    func showAlertForIncompleteFields() {
        let alert = UIAlertController(title: "WARNING: Incomplete Fields",
                                      message: "Please fill out all the text fields in order to create your event!",
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
    
    /* FUNC: dismissing picker controller */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    /* FUNC: grabs image from picker */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let originalImage = info["UIImagePickerControllerOriginalImage"] {
            selectedImageFromPicker = originalImage as! UIImage
        }
        if let selectedImage = selectedImageFromPicker {
            eventImageView.image = selectedImage
            let imagePath: NSURL = info[UIImagePickerControllerReferenceURL] as! NSURL
            imageName = NSUUID().uuidString
            uploadButton.setTitle("", for: .normal)
            uploadButton.layer.borderColor = UIColor.white.cgColor
            
            storeImageToFirebase()
            dismiss(animated: true, completion: nil)
        }
    }
    
    /* FUNC: stores image that is uploaded to Firebase 
       1.) puts image into Storage
       2.) takes the data and retrieves the imgURL stored in Firebase for Event object */
    func storeImageToFirebase() {
        let storageRef = Storage.storage().reference().child("eventPics").child(imageName!)
        
        if let uploadData = UIImagePNGRepresentation(eventImageView.image!) {
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            storageRef.putData(uploadData, metadata: metadata).observe(.success) { (snapshot) in
                let url = snapshot.metadata?.downloadURL()?.absoluteString
                self.imgURL = url
                print(self.imgURL)
            }
        }
        
    }
}
