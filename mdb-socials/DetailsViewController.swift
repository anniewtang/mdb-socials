//
//  DetailsViewController.swift
//  mdb-socials
//
//  Created by Annie Tang on 9/26/17.
//  Copyright © 2017 Annie Tang. All rights reserved.
//

import UIKit
import Firebase

class DetailsViewController: UIViewController {

    /* event information */
    var event: Event!
    var eventImage: UIImage!
    var eventImageView: UIImageView!
    
    var eventName: UILabel!
    var creator: UILabel!
    var numInterested: UILabel!
    var numInterestedText: UILabel!
    
    var eventDescTitle: UILabel!
    var eventDesc: UILabel!
    
    /* navigation & buttons */
    var interestedButton: UIButton!
    
    var navBar: UINavigationBar!
    var logOutButton: UIButton!
    
    /* data info */
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImageView()
        setupLabelsAndButtons()
        
    }
    
    /* UI: setting up ImageView and populates .image */
    func setupImageView() {
        eventImageView = UIImageView(frame:
            CGRect(x: 43,
                   y: 159,
                   w: 175,
                   h: 203))
        eventImageView.contentMode = .scaleAspectFill
        eventImageView.clipsToBounds = true
        view.addSubview(eventImageView)
        eventImageView.image = eventImage
    }
    
    /* UI: calls to set up all labels and buttons */
    func setupLabelsAndButtons() {
        setupRightCorner()
        setupNumInterested()
        setupBottomHalf()
    }
    
    /* UI: setting up eventName, creator */
    func setupRightCorner() {
        let WIDTH: CGFloat = 106
        let X: CGFloat = 231
        
        eventName = UILabel(frame:
            CGRect(x: X,
                   y: 159,
                   width: WIDTH,
                   height: 53))
        eventName.text = event.eventName
        eventName.textColor = Constants.grayBlue
        eventName.textAlignment = .left
        eventName.lineBreakMode = NSLineBreakMode.byWordWrapping
        eventName.numberOfLines = 2
        eventName.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        view.addSubview(eventName)
        
        creator = UILabel(frame:
            CGRect(x: X,
                   y: 212,
                   w: WIDTH,
                   h: 40))
        creator.text = "By: " + String(describing: event.creator!)
        creator.textColor = Constants.lightGray
        creator.textAlignment = .left
        creator.lineBreakMode = NSLineBreakMode.byWordWrapping
        creator.numberOfLines = 2
        creator.font = UIFont(name: "HelveticaNeue", size: 15)
        view.addSubview(creator)
    }
    
    /* UI: sets up NumInterested text */
    func setupNumInterested() {
        numInterestedText = UILabel(frame:
            CGRect(x: 250.86,
                   y: 344.37,
                   width: 100,
                   height: 18))
        numInterestedText.text = "INTERESTED"
        numInterestedText.textColor = Constants.brightBlue
        numInterestedText.textAlignment = .left
        numInterestedText.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        view.addSubview(numInterestedText)
        
        numInterested = UILabel(frame:
            CGRect(x: 230.67,
                   y: 340.7,
                   width: 15,
                   height: 22))
        numInterested.text = "\(event.numInterested!)"
        numInterested.textColor = Constants.brightBlue
        numInterested.textAlignment = .left
        numInterested.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        view.addSubview(numInterested)
    }
    
    /* UI: setting up RSVPButton, event desc */
    func setupBottomHalf() {
        let WIDTH: CGFloat = 290
        let X: CGFloat = 43
        
        eventDescTitle = UILabel(frame:
            CGRect(x: X,
                   y: 372,
                   width: WIDTH,
                   height: 22))
        eventDescTitle.text = "EVENT DESCRIPTION"
        eventDescTitle.textColor = Constants.grayBlue
        eventDescTitle.textAlignment = .left
        eventDescTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        view.addSubview(eventDescTitle)
        
        eventDesc = UILabel(frame:
            CGRect(x: X,
                   y: 394,
                   width: WIDTH,
                   height: 22))
        eventDesc.text = event.desc
        eventDesc.textColor = Constants.gray
        eventDesc.textAlignment = .left
        eventDesc.lineBreakMode = NSLineBreakMode.byWordWrapping
        eventDesc.numberOfLines = 2
        eventDesc.font = UIFont(name: "HelveticaNeue", size: 20)
        view.addSubview(eventDesc)
        
        interestedButton = UIButton(frame:
            CGRect(x: X,
                   y: 480,
                   width: WIDTH,
                   height: 60))
        interestedButton.layer.cornerRadius = 3
        interestedButton.backgroundColor = Constants.brightBlue
        interestedButton.setTitle("RSVP INTERESTED", for: .normal)
        interestedButton.setTitleColor(.white, for: .normal)
        interestedButton.titleLabel?.font = UIFont(
            name: "HelveticaNeue-Bold",
            size: 20)
        interestedButton.addTarget(self,action: #selector(rsvpInterested),
                                   for: .touchUpInside)
        view.addSubview(interestedButton)
    }
}
