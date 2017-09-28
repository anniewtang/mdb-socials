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
    var text: String?
    var imageUrl: String?
    var creatorID: String?
    var creator: String?
    var id: String?
    var image: UIImage?
    
    
    init(id: String, eventDict: [String:Any]?) {
        self.id = id
        if postDict != nil {
            if let text = eventDict!["text"] as? String {
                self.text = text
            }
            if let imageUrl = eventDict!["imageUrl"] as? String {
                self.imageUrl = imageUrl
            }
            if let creatorID = eventDict!["creatorID"] as? String {
                self.posterId = creatorID
            }
            if let creator = eventDict!["creator"] as? String {
                self.creator = creator
            }
        }
    }
    
    init() {
        self.text = "This is a god dream"
        self.imageUrl = "https://cmgajcmusic.files.wordpress.com/2016/06/kanye-west2.jpg"
        self.id = "1"
        self.creator = "Kanye West"
    }
    
    func getProfilePic(withBlock: @escaping () -> ()) {
        //TODO: Get User's profile picture
        let ref = FIRStorage.storage().reference().child("/profilepics/\(creatorID!)")
        ref.data(withMaxSize: 1 * 2048 * 2048) { data, error in
            if let error = error {
                print(error)
            } else {
                self.image = UIImage(data: data!)
                withBlock()
            }
        }
    }
}
