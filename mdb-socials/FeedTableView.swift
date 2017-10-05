//
//  Feed+TableView.swift
//  mdb-socials
//
//  Created by Annie Tang on 10/1/17.
//  Copyright © 2017 Annie Tang. All rights reserved.
//

import UIKit

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    /* UI: sets number of sections in TableView */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /* UI: sets number of rows in TableView */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEvents.count
    }
    
    /* FUNC: dequeue & activate each cell */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /* dequeue cell and remove/reset from subview; initialize new cell */
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! FeedTableViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        let event: Event = allEvents[indexPath.row]
        cell.event = event
        cell.awakeFromNib()

        cell.creatorName.text = "By: " + event.creator!
        cell.eventName.text = event.eventName
        Utils.getImageFromURL(url: event.imageUrl!) { img in
            cell.eventPic.image = img
        }
        if cell.eventPic.image == nil {
            cell.eventPic.image = #imageLiteral(resourceName: "default")
        }
        
        let num: Int = event.numInterested!
        var noun: String!
        if num == 1 {
            noun = " person"
        } else {
            noun = " people"
        }
        
        cell.numInterested.text = String(num) + noun
        
        return cell
    }
    
    /* FUNC: passes Event object to DetailsVC, upon selection */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventToPass = allEvents[indexPath.row]
        performSegue(withIdentifier: "toDetails", sender: self)
    }
    
    /* UI: sets height of each row */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 5
    }
    
}
