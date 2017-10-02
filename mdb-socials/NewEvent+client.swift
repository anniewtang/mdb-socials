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
    /* FUNC: creating a new Event */
    func addNewEvent(sender: UIButton!) {
        let eventsRef = Database.database().reference().child("Events")
        if checkForCompletion() {
            let id = eventsRef.childByAutoId().key
            let newEvent = ["eventID": id,
                            "eventName": eventName.text ?? "[no title]",
                            "desc": descTextField.text ?? "[no description]",
                            "imageUrl": imgURL as Any,
                            "creator": currentUser?.name ?? "[no user]",
                            "date": datePicker.date.timeIntervalSince1970,
                            "numInterested": 0] as [String : Any]
            //            let event = Event(eventDict: newEvent)
            let FeedVC = storyboard?.instantiateViewController(withIdentifier: "FeedViewController") as! FeedViewController
            //            FeedVC.allEvents.append(event)
            goBackToFeed()
        } else {
            showAlertForIncompleteFields()
        }
    }
    
    func uploadToFirebase() {
        self.id = eventRef.childByAutoId().key
        let childUpdates = ["/\(id)/": eventDict]
        eventRef.updateChildValues(childUpdates)
    }
}
