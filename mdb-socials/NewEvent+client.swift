
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
    
    /* FUNC: creates & sets event ID */
    func getEventID() {
        let eventsRef = Database.database().reference().child("Events")
        self.eventID = eventsRef.childByAutoId().key
    }
    
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
                    print("FIREBASE URL: ", self.imgURL)
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
        /* creating the dict for Firebase */
        let interestedUsers: [String] = [currentUser.id]
        let eventDict = ["id": eventID,
                        "imageUrl": imgURL,
                        "eventName": eventNameTextField.text!,
                        "creator": currentUser.name!,
                        "creatorID": currentUser.id!,
                        "desc": descTextField.text!,
                        "date": datePicker.date.timeIntervalSince1970,
                        "numInterested": 0,
                        "interestedUsers": interestedUsers] as [String : Any]

//        /* add the event to Firebase Database */
//        eventsRef.child(self.eventID).setValue(eventDict, withCompletionBlock: { (error, eventsRef) in
//            if error != nil {
//                print(error.debugDescription)
//                return
//            }
//        })
        
        /* create and add the Event object to the tableview */
        let event = Event(eventDict: eventDict)
        event.setupAttributes()
        let FeedVC = storyboard?.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
        FeedVC.allEvents.append(event)
        
        /* add event to firebase */
        event.sendToFirebase()
        
        /* return user to the Feed */
        goBackToFeed()
 
    }
}
