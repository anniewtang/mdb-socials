//
//  Details+Handler.swift
//  mdb-socials
//
//  Created by Annie Tang on 10/4/17.
//  Copyright © 2017 Annie Tang. All rights reserved.
//

import UIKit

extension DetailsViewController {
    /* FUNC: returns true if rsvp-ing user is the creator */
    func getSelfInterestStatus() -> Bool {
        return event.checkSelfInterest(uid: currentUser.id)
    }

    /* FUNC: returns true if user is already interested */
    func getRSVPStatus() -> Bool {
        return event.isInterestedUser(uid: currentUser.id)
    }

    /* FUNC: updates rsvp amnt locally & in firebase */
    func rsvpInterested() {
        let selfInterest = getSelfInterestStatus()
        let rsvpStatus = getRSVPStatus()
        if selfInterest {
            let msg = "You can't RSVP to your own event!"
            let alert = Utils.createAlert(warningMessage: msg)
            present(alert, animated: true, completion: nil)
        } else if rsvpStatus {
            let msg = "You already RSVP-ed to this event!"
            let alert = Utils.createAlert(warningMessage: msg)
            present(alert, animated: true, completion: nil)
        } else {
            event.addInterestedUser(uid: currentUser.id)
            event.updateNumInterested()
            event.sendToFirebase()
            numInterested.text = "\(event.numInterested!)"
            interestedButton.setTitle("Successfully RSVP-ed!", for: .normal)
            interestedButton.backgroundColor = Utils.grayBlue
        }
    }
}
