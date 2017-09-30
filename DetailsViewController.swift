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
    
    let grayBlue = UIColor(hexString: "#6074AC")
    let brightBlue = UIColor(hexString: "#4C9BD0")
    let lightGray = UIColor(hexString: "#95989A")
    let gray = UIColor(hexString: "#95989A")
    
    var event: Event!
    var eventImageView: UIImageView!
    
    var eventName: UILabel!
    var creator: UILabel!
    var numInterested: UILabel!
    var numInterestedText: UILabel!
    
    var eventDescTitle: UILabel!
    var eventDesc: UILabel!
    var interestedButton: UIButton!
    
    var navBar: UINavigationBar!
    var logOutButton: UIButton!
    
    
    let ref: DatabaseReference = Database.database().reference()
    
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
        
        Utils.getImage(url: event.imageUrl!) { img in
            self.eventImageView.image = img
        }
        if self.eventImageView.image == nil {
            self.eventImageView.image = #imageLiteral(resourceName: "default")
        }
        
    }
    
    /* UI: calls to set up all labels and buttons */
    func setupLabelsAndButtons() {
        setupRightCorner()
        setupDesc()
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
        eventName.textColor = grayBlue
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
        creator.textColor = lightGray
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
        numInterestedText.textColor = brightBlue
        numInterestedText.textAlignment = .left
        numInterestedText.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        view.addSubview(numInterestedText)
        
        numInterested = UILabel(frame:
            CGRect(x: 230.67,
                   y: 340.7,
                   width: 10,
                   height: 22))
        numInterested.text = "\(event.numInterested)"
        numInterested.textColor = brightBlue
        numInterested.textAlignment = .left
        numInterested.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        view.addSubview(numInterested)
        view.bringSubview(toFront: numInterested)
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
        eventDescTitle.textColor = grayBlue
        eventDescTitle.textAlignment = .left
        eventDescTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        view.addSubview(eventDescTitle)
        
        eventDesc = UILabel(frame:
            CGRect(x: X,
                   y: 394,
                   width: WIDTH,
                   height: 22))
        eventDesc.text = event.desc
        eventDesc.textColor = gray
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
        interestedButton.backgroundColor = brightBlue
        interestedButton.setTitle("RSVP INTERESTED", for: .normal)
        interestedButton.setTitle("RSVP-ed!", for: .selected)
        interestedButton.setTitleColor(.white, for: .normal)
        interestedButton.titleLabel?.font = UIFont(
            name: "HelveticaNeue-Bold",
            size: 20)
        interestedButton.addTarget(self,action: #selector(rsvpInterested),
                                   for: .touchUpInside)
        view.addSubview(interestedButton)
    }
    
    /* UI: set up description */
    func setupDesc() {
        let desc: UILabel = UILabel(frame:
            CGRect(x: view.frame.width * 0.1,
                   y: view.frame.width * 0.7,
                   width: view.frame.width * 0.8,
                   height: view.frame.width * 0.25))
        desc.text = event.desc
        desc.textColor = .darkGray
        desc.textAlignment = .left
        desc.font = desc.font.withSize(16)
        view.addSubview(desc)

    }
    
    /* FUNC: updates rsvp amnt locally & in firebase */
    func rsvpInterested() {
        event.numInterested! += 1
        ref.child("Events/\(String(describing: event.id))/numInterested").setValue(event.numInterested)
    }
}
