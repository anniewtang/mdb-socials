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
    var numInterested: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupEventPic()
        setupCreatorName()
        setupEventName()
        setupNumInterested()
    }
    
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
    
    func setupEventName() {
        eventName = UILabel(frame:
            CGRect(x: contentView.frame.height * 1.2,
                   y: 0,
                   width: contentView.frame.width - contentView.frame.height * 1.2,
                   height: contentView.frame.height * 0.7))
        eventName.textColor = UIColor.black
        eventName.textAlignment = .left
        eventName.font = eventName.font.withSize(18)
        contentView.addSubview(eventName)
        
    }
    
    func setupCreatorName() {
        creatorName = UILabel(frame:
            CGRect(x: contentView.frame.height * 1.2,
                   y: contentView.frame.height * 0.25,
                   width: contentView.frame.width * 0.5,
                   height: contentView.frame.height * 0.8))
        creatorName.textColor = UIColor.lightGray
        creatorName.textAlignment = .left
        creatorName.font = creatorName.font.withSize(14)
        contentView.addSubview(creatorName)
    }
    
    func setupNumInterested() {
        numInterested = UILabel(frame:
            CGRect(x: 0,
                   y: contentView.frame.height,
                   width: contentView.frame.width * 0.9,
                   height: contentView.frame.height))
        numInterested.textColor = UIColor.lightGray
        numInterested.textAlignment = .right
        numInterested.font = creatorName.font.withSize(14)
        contentView.addSubview(numInterested)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
}
