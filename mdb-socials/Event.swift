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
    
    /* Things to pass over 
     1.) eventName
     2.) desc
     3.) imageUrl
     4.) creator
     5.) date
     6.) numInterested
     */
    
    init(default: String) {
        self.desc = "go go"
        self.imageUrl = "https://cmgajcmusic.files.wordpress.com/2016/06/kanye-west2.jpg"
        self.numInterested = 1
        self.creator = "Kanye West"
        self.eventName = "Yeezy concert"
    }
    
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
