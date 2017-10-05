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


class Event: NSObject {
    
    var id: String!
    var imageUrl: String!
    var eventName: String!
    var creator: String!
    var desc: String!
    var date: Date!
    var numInterested: Int!

    var eventDict: [String: Any]!
    
    init(eventDict: [String: Any]) {
        super.init()
        self.eventDict = eventDict
        setupAttributes()
    }
    
    func setupAttributes() {
        self.id = eventDict["id"] as! String
        self.imageUrl = eventDict["imageUrl"] as! String
        self.eventName = eventDict["eventName"] as! String
        self.creator = eventDict["creator"] as! String
        self.desc = eventDict["desc"] as! String
        self.date = eventDict["date"] as! Date
        self.numInterested = eventDict["numInterested"] as! Int
    }
    
//    init(default: String) {
//        self.desc = "go go"
//        self.imageUrl = "https://cmgajcmusic.files.wordpress.com/2016/06/kanye-west2.jpg"
//        self.numInterested = 1
//        self.creator = "Kanye West"
//        self.eventName = "Yeezy concert"
//    }
    
    override init() {
        
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
