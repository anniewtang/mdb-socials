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
    
    let grayBlue = UIColor(red:0.58, green:0.67, blue:0.75, alpha:1.0)
    let lightGrayBlue = UIColor(red:0.83, green:0.86, blue:0.88, alpha:1.0)
    let darkGray = UIColor(red:0.17, green:0.25, blue:0.30, alpha:1.0)
    
    var event: Event!
    var eventImageView: UIImageView!
    
    var eventName: UILabel!
    var creator: UILabel!
    var numInterested: UILabel!
    
    var interestedButton: UIButton!
    
    var navBar: UINavigationBar!
    var logOutButton: UIButton!
    
    
    let ref: DatabaseReference = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupLabelsAndButtons()
        setupImageView()
        setupDesc()
    }
    
    /* UI: setting up ImageView and populates .image */
    func setupImageView() {
        eventImageView = UIImageView(frame:
            CGRect(x: view.frame.width * 0.1,
                   y: view.frame.width * 0.15,
                   width: view.frame.width * 0.4,
                   height: view.frame.width * 0.5))
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
    
    /* UI: eventName, creator, number interested, RSVP button */
    func setupLabelsAndButtons() {
        let OFFSET: CGFloat = view.frame.height * 0.1
        let HEIGHT: CGFloat = view.frame.height * 0.08
        let WIDTH: CGFloat = view.frame.width * 0.495
        let Y: CGFloat = view.frame.width * 0.47
        let X: CGFloat = view.frame.width * 0.505
        
        eventName = UILabel(frame:
            CGRect(x: X,
                   y: Y - OFFSET*3,
                   width: WIDTH,
                   height: HEIGHT))
        eventName.text = event.eventName
        eventName.textColor = UIColor.darkGray
        eventName.textAlignment = .left
        eventName.font = eventName.font.withSize(20)
        view.addSubview(eventName)
        
        creator = UILabel(frame:
            CGRect(x: X,
                   y: Y - OFFSET*2,
                   width: WIDTH,
                   height: HEIGHT))
        creator.text = event.creator
        creator.textColor = .lightGray
        creator.textAlignment = .left
        creator.font = creator.font.withSize(14)
        view.addSubview(creator)
        
        numInterested = UILabel(frame:
            CGRect(x: X,
                   y: Y - OFFSET,
                   width: WIDTH,
                   height: HEIGHT))
        numInterested.text = event.creator
        numInterested.textColor = .lightGray
        numInterested.textAlignment = .right
        numInterested.font = numInterested.font.withSize(14)
        view.addSubview(numInterested)
        
        
        interestedButton = UIButton(frame:
            CGRect(x: X,
                   y: Y,
                   width: WIDTH,
                   height: view.frame.height * 0.1))
        interestedButton.layer.cornerRadius = 3
        interestedButton.backgroundColor = lightGrayBlue
        interestedButton.setTitle("RSVP: Interested", for: .normal)
        interestedButton.setTitle("RSVP-ed!", for: .selected)
        interestedButton.setTitleColor(darkGray, for: .normal)
        interestedButton.setTitleColor(.green, for: .selected)
        interestedButton.titleLabel?.font = UIFont(
            name: (interestedButton.titleLabel?.font.fontName)!,
            size: 14)
        interestedButton.addTarget(self,
                                   action: #selector(rsvpInterested),
                                   for: .touchUpInside)
//        view.addSubview(interestedButton)
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
