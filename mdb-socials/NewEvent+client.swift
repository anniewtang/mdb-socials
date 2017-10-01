//
//  NewEvent+client.swift
//  mdb-socials
//
//  Created by Annie Tang on 10/1/17.
//  Copyright © 2017 Annie Tang. All rights reserved.
//

import UIKit
import Firebase

extension NewEventViewController {
    func uploadToFirebase() {
        self.id = eventRef.childByAutoId().key
        let childUpdates = ["/\(id)/": eventDict]
        eventRef.updateChildValues(childUpdates)
    }
}
