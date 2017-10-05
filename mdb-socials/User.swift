//
//  User.swift
//  mdb-socials
//
//  Created by Annie Tang on 9/27/17.
//  Copyright © 2017 Annie Tang. All rights reserved.
//

import Foundation
import UIKit

class User: NSObject {
    var name: String!
    var email: String!
    var id: String!
    var rsvped = [String]()
    
    var userDict: [String: Any]!
    
    init(userDict: [String: Any]) {
        super.init()
        self.userDict = userDict
        setupAttributes()
    }
    
    func setupAttributes() {
        self.name = userDict["name"]
        self.email = userDict["email"]
        self.id = userDict["id"]
        self.rsvped = userDict["rsvped"]
    }
}
