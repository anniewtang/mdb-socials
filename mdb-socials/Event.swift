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
    var creatorID: String!
    var desc: String!
    var date: Date!
    var numInterested: Int!
    var interestedUsers: [String]!

    var eventDict: [String: Any]!
    
    init(eventDict: [String: Any]) {
        super.init()
        self.eventDict = eventDict
        setupAttributes()
    }
    
    /* FUNC: initialization helper */
    func setupAttributes() {
        self.id = eventDict["id"] as! String
        self.imageUrl = eventDict["imageUrl"] as! String
        self.eventName = eventDict["eventName"] as! String
        self.creator = eventDict["creator"] as! String
        self.creatorID = eventDict["creatorID"] as! String
        self.desc = eventDict["desc"] as! String
        self.date = eventDict["date"] as? Date
        self.numInterested = eventDict["numInterested"] as! Int
        if let interested = eventDict["interestedUsers"] as? [String] {
            self.interestedUsers = interested
        } else {
            self.interestedUsers = []
        }
    }
    
    /* FUNC: returns true if current user is the same as the creator */
    func checkSelfInterest(uid: String) -> Bool {
        return uid == self.creatorID
    }
    
    /* FUNC: returns true if User already marked as interested */
    func isInterestedUser(uid: String) -> Bool {
        return interestedUsers.contains(uid)
    }
    
    /* FUNC: adds User to [interestedUser] */
    func addInterestedUser(uid: String) {
        self.interestedUsers.append(uid)
        eventDict["interestedUsers"] = self.interestedUsers
    }
    
    /* FUNC: updates number of people interested */
    func updateNumInterested() {
        self.numInterested! += 1
        self.eventDict["numInterested"] = self.numInterested
    }
    
    /* FUNC: sends event to Firebase */
    func sendToFirebase() {
        let ref: DatabaseReference = Database.database().reference()
        ref.child("Events").child(String(describing: self.id!)).setValue(eventDict, withCompletionBlock: { (error, eventsRef) in
            if error != nil {
                print(error.debugDescription)
                return
            }
        })
        
//        ref.child("Events").setValue(self.eventDict)
    }
}
