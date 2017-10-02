//
//  NewEvent+client.swift
//  mdb-socials
//
//  Created by Annie Tang on 10/1/17.
//  Copyright © 2017 Annie Tang. All rights reserved.
//

import UIKit
import Firebase

extension NewEventViewController {
    
    /* FUNC: puts uploaded image into Firebase Storage (using eventID), and saves imgURL */
    func storeImageToFirebase() {
        let storageRef = Storage.storage().reference().child("EventPics").child(eventID)
        
        if let uploadData = UIImagePNGRepresentation(eventImageView.image!) {
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error.debugDescription)
                    return
                }
                if let url = metadata?.downloadURL()?.absoluteString {
                    self.imgURL = url
                }
            })
            
//            let metadata = StorageMetadata()
//            metadata.contentType = "image/jpeg"
//            storageRef.putData(uploadData, metadata: metadata).observe(.success) { (snapshot) in
//                let url = snapshot.metadata?.downloadURL()?.absoluteString
//                self.imgURL = url
//                print("url", self.imgURL)
//            }
        }
    }
    
    /* FUNC: creats eventDict & adds the new event to Firebase Database */
    func addEventToFirebase() {
        let eventsRef = Database.database().reference().child("Events")
        
        /* creating the dict for Firebase */
        eventID = eventsRef.childByAutoId().key
        let eventDict = ["id": eventID,
                        "imageUrl": imgURL,
                        "eventName": eventNameTextField.text!,
                        "creator": currentUser.name!,
                        "desc": descTextField.text!,
                        "date": datePicker.date.timeIntervalSince1970,
                        "numInterested": 0] as [String : Any]
        
        /* add the event to Firebase Database */
        eventsRef.child(eventID).setValue(eventDict, withCompletionBlock: { (error, eventsRef) in
            if error != nil {
                print(error.debugDescription)
                return
            }
        })
            
            /* return user to the Feed */
            goBackToFeed()
            
            /* create and add the Event object to the tableview -- UNNEEDED? because of the fetchData code?
             let event = Event()
             event.setValuesForKeys(eventDict)
             let FeedVC = storyboard?.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
            FeedVC.allEvents.append(event)
            */
    }
}
