//
//  Utils.swift
//  mdb-socials
//
//  Created by Annie Tang on 9/27/17.
//  Copyright © 2017 Annie Tang. All rights reserved.
//

import Foundation
import Haneke

class Utils {
    static let grayBlue = UIColor(hexString: "#6074AC")
    static let brightBlue = UIColor(hexString: "#4C9BD0")
    static let lightGray = UIColor(hexString: "#95989A")
    static let gray = UIColor(hexString: "#95989A")
    
    /* FUNC: uses haneke to grab image from url */
    static func getImage(url: String, withBlock: @escaping (UIImage) -> Void) {
        let cache = Shared.imageCache
        if let imageUrl = URL(string: url) {
            cache.fetch(URL: imageUrl).onSuccess({ img in
                withBlock(img)
            })
        }
    }
    
    /* FUNC: presents popup alert if incomplete name, desc, or date fields */
    static func createAlert(warningMessage: String) -> UIAlertController {
        let alert = UIAlertController(title: "WARNING:",
                                      message: warningMessage,
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        return alert
    }
}

