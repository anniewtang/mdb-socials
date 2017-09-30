//
//  FeedTableViewCell.swift
//  mdb-socials
//
//  Created by Annie Tang on 9/27/17.
//  Copyright © 2017 Annie Tang. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    var event: Event!
    
    var eventPic: UIImageView!
    var creatorName: UILabel!
    var eventName: UILabel!
    
    var rsvpTitle: UILabel!
    var numInterested: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupEventPic()
        setupCreatorName()
        setupEventName()
        setupNumInterested()
    }
    
    /* UI: setting up event picture image view */
    func setupEventPic() {
        eventPic = UIImageView(frame:
            CGRect(x: 0,
                   y: 0,
                   width: contentView.frame.height,
                   height: contentView.frame.height))
        eventPic.contentMode = .scaleAspectFill
        eventPic.clipsToBounds = true
        contentView.addSubview(eventPic)
    }
    
    /* UI: setting up event name label */
    func setupEventName() {
        eventName = UILabel(frame:
            CGRect(x: contentView.frame.height * 1.08,
                   y: contentView.frame.height * 0.25,
                   width: contentView.frame.width - contentView.frame.height,
                   height: contentView.frame.height * 0.5))
        eventName.textColor = UIColor.black
        eventName.textAlignment = .left
        eventName.font = eventName.font.withSize(18)
        contentView.addSubview(eventName)
        
    }
    
    /* UI: setting up "created by" label */
    func setupCreatorName() {
        creatorName = UILabel(frame:
            CGRect(x: contentView.frame.height * 1.08,
                   y: contentView.frame.height * 0.25,
                   width: contentView.frame.width * 0.5,
                   height: contentView.frame.height * 0.8))
        creatorName.textColor = UIColor.lightGray
        creatorName.textAlignment = .left
        creatorName.font = creatorName.font.withSize(13)
        contentView.addSubview(creatorName)
    }
    
    /* UI: creating title & number label for RSVP */
    func setupNumInterested() {
        rsvpTitle = UILabel(frame:
            CGRect(x: 0,
                   y: contentView.frame.height * 0.25,
                   width: contentView.frame.width * 0.95,
                   height: contentView.frame.height * 0.5))
        rsvpTitle.textColor = UIColor.lightGray
        rsvpTitle.textAlignment = .right
        rsvpTitle.font = rsvpTitle.font.withSize(14)
        contentView.addSubview(rsvpTitle)
        rsvpTitle.text = "RSVP-ed:"
        
        numInterested = UILabel(frame:
            CGRect(x: 0,
                   y: contentView.frame.height * 0.25,
                   width: contentView.frame.width * 0.95,
                   height: contentView.frame.height * 0.8))
        numInterested.textColor = UIColor.lightGray
        numInterested.textAlignment = .right
        numInterested.font = creatorName.font.withSize(14)
        contentView.addSubview(numInterested)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}
