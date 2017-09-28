//
//  NewSocialViewController.swift
//  mdb-socials
//
//  Created by Annie Tang on 9/26/17.
//  Copyright © 2017 Annie Tang. All rights reserved.
//

import UIKit
import Firebase

protocol NewEventViewControllerProtocol {
    func dismissViewController()
}

class NewEventViewController: UIViewController {
    
    var delegate: FeedViewController!
    
    var eventsRef: DatabaseReference!
    var currentUser: User?

    var newEventView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNewEventView()
    }

    
    func setupNewEventView() {
        newEventView = UITextField(frame: CGRect(x: 10, y: 10, width: UIScreen.main.bounds.width - 20, height: 0.3 * UIScreen.main.bounds.height))
        newEventView.layoutIfNeeded()
        newEventView.layer.shadowRadius = 2.0
        newEventView.layer.masksToBounds = true
        newEventView.placeholder = "Create a social event!"
        view.addSubview(newEventView)
    }
    
    func addNewEvent(sender: UIButton!) {
        let desc = newEventView.text!
        newEventView.removeFromSuperview()
        let newEvent = ["desc": desc, "creator": currentUser?.name, "imageUrl": currentUser?.imageUrl, "creatorID": currentUser?.id] as [String : Any]
        let key = eventsRef.childByAutoId().key
        let childUpdates = ["/\(key)/": newEvent]
        eventsRef.updateChildValues(childUpdates)
    }
    
    func goBack(sender: AnyObject) {
        self.dismiss(animated: true) {
            self.delegate!.dismissViewController()
        }
    }
}
