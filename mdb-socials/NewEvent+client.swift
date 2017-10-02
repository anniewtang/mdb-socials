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
    
    /* FUNC: adding the new event to Firebase */
    func addNewEvent(sender: UIButton!) {
        let eventsRef = Database.database().reference().child("Events")
        if checkForCompletion() {
            
            /* creating the dict for Firebase */
            let id = eventsRef.childByAutoId().key
            let eventDict = ["id": id,
                            "imageUrl": imgURL!,
                            "eventName": eventNameTextField.text!,
                            "creator": currentUser.name,
                            "desc": descTextField.text!,
                            "date": datePicker.date.timeIntervalSince1970,
                            "numInterested": 0] as [String : Any]
            
            /* add the event to Firebase Database */
            eventsRef.child(id).setValue(eventDict, withCompletionBlock: { (error, eventsRef) in
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
        } else {
            showAlertForIncompleteFields()
        }
    }
}
