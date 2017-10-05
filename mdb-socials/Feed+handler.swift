//
//  Feed+handler.swift
//  mdb-socials
//
//  Created by Annie Tang on 10/1/17.
//  Copyright © 2017 Annie Tang. All rights reserved.
//

import UIKit
import Firebase

extension FeedViewController {
    
    /* FUNC: fetching current user from firebase */
    func fetchUser(withBlock: @escaping () -> ()) {
        let ref = Database.database().reference()
        let uid = (self.auth.currentUser?.uid)!
        ref.child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            let user = User()
            let userDict = snapshot.value as! [String: Any]!
            user.setValuesForKeys(userDict!)
            self.currentUser = user
            withBlock()
        })
    }
    
    /* FUNC: fetching newly added events from firebase */
    func fetchEvents(withBlock: @escaping () -> ()) {
        let eventsRef = Database.database().reference().child("Events")
        eventsRef.observe(.childAdded, with: { (snapshot) in
            let eventDict = (snapshot.value as! [String : Any])
            if let event = self.loadedEvents[eventDict["id"] as! String] {
                event.setupAttributes()
            } else {
                let event = Event(eventDict: eventDict)
                self.allEvents.append(event)
            }
            withBlock()
        })
    }
    
    /* FUNC: pass the events object to DetailsVC */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails" {
            let eventDetails = segue.destination as! DetailsViewController
            eventDetails.event = eventToPass
            eventDetails.currentUser = currentUser
            
            Utils.getImageFromURL(url: eventToPass.imageUrl!) { img in
                eventDetails.eventImage = img
            }
            if eventDetails.eventImage == nil {
                eventDetails.eventImage = #imageLiteral(resourceName: "default")
            }
        }
    }
    
    /* TRANSITION: presents NewEventVC modally */
    func goToNewEvent(sender: UIButton!) {
        let newEvent = self.storyboard?.instantiateViewController(withIdentifier: String(describing: NewEventViewController.self)) as! NewEventViewController
        newEvent.currentUser = currentUser
        present(newEvent, animated: true, completion: nil)
    }
    
    /* FUNC: logs the user out */
    func logOut() {
        print("Logging out.")
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
