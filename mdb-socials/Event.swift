//
//  SocialEvent.swift
//  mdb-socials
//
//  Created by Annie Tang on 9/27/17.
//  Copyright © 2017 Annie Tang. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class Event {
    
    var id: String?
    
    var eventName: String?
    var imageUrl: String?
    var desc: String?
    
    var creator: String?
    var date: Date?
    
    var numInterested: Int!
    
    var image: UIImage?
    
    init(id: String, eventDict: [String:Any]?) {
        self.id = id
        if eventDict != nil {
            if let eventName = eventDict!["eventName"] as? String {
                self.eventName = eventName
            }
            if let desc = eventDict!["desc"] as? String {
                self.desc = desc
            }
            if let imageUrl = eventDict!["imageUrl"] as? String {
                self.imageUrl = imageUrl
            }
            if let creator = eventDict!["creator"] as? String {
                self.creator = creator
            }
            if let eventID = eventDict!["eventID"] as? String {
                self.id = eventID
            }
            if let date = eventDict!["date"] as? Date {
                self.date = date
            }
            if let numInterested = eventDict!["interested"] as? Int {
                self.numInterested = numInterested
            }
        }
    }
    
    init() {
        self.desc = "go go"
        self.imageUrl = "https://cmgajcmusic.files.wordpress.com/2016/06/kanye-west2.jpg"
        self.numInterested = 1
        self.creator = "Kanye West"
        self.eventName = "Yeezy concert"
    }

    
//    let childUpdates = ["/\(key)/": newEvent]
//    let key = eventsRef.childByAutoId().key
//    eventsRef.updateChildValues(childUpdates)
    
//    func getEventPic(withBlock: @escaping () -> ()) {
//        //TODO: Get User's profile picture
//        let ref = Storage.storage().reference().child("/eventPics/\(id!)")
//        ref.data(withMaxSize: 1 * 2048 * 2048) { data, error in
//            if let error = error {
//                print(error)
//            } else {
//                self.image = UIImage(data: data!)
//                withBlock()
//            }
//        }
//    }
}
