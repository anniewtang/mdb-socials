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
    /* FUNC: uses haneke to grab image from url */
    static func getImageFromURL(url: String, withBlock: @escaping (UIImage) -> Void) {
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

