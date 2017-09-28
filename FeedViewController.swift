//
//  FeedViewController
//  mdb-socials
//
//  Created by Annie Tang on 9/26/17.
//  Copyright © 2017 Annie Tang. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    var tableView: UITableView!
    
    /* order of images in pokemonImages should be same as in results */
    var allEvents: [Event]!
    var eventToPass: Event!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
    }
    
    /* Initializing table view, and adding it to view */
    func setupTableView(){
        tableView = UITableView(frame:
            CGRect(x: 0,
                   y: UIApplication.shared.statusBarFrame.maxY + view.frame.height * 0.1 + 10,
                   width: view.frame.width,
                   height: view.frame.height - UIApplication.shared.statusBarFrame.maxY))
        
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "tableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50/2, right: 0)
        view.addSubview(tableView)
    }
    
    /* Overriding prepare function for DetailsVC segue -> pass in events object */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails" {
            let eventDetails = segue.destination as! DetailsViewController
            eventDetails.event = eventToPass
        }
    }
}



/* extension of TABLEVIEWS */
extension FeedViewController: UITableViewDataSource, UITableViewDelegate {
    /* number of sections/types of cells in tableview */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /* number of cells in section of tableview */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEvents.count
    }
    
    /* dequeue & set up cell at indexPath.row
     pass over the pokemon image, name, and number into the tableview cell */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /* dequeue cell and remove/reset from subview; initialize new cell */
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! FeedTableViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        let event: Event = allEvents[indexPath.row]
        cell.event = event
        cell.awakeFromNib()
        
        /* setting up the cell; giving it all the info we need 
         1.) name of member who posted
         2.) name of event
         3.) picture of event
         4.) number of people who RSVP’d “Interested”*/
        cell.creatorName.text = event.creator
        cell.eventName.text = event.eventName
        Utils.getImage(url: event.imageUrl) { img in
            cell.eventPic.image = img
        }
        if cell.eventPic.image == nil {
            cell.eventPic.image = #imageLiteral(resourceName: "pokeball")
        }
        cell.numInterested.text = String(event.numInterested)
        
        return cell
    }
    
    /* action after tableCell is selected
     "passes" the event object over into the DetailsVC through segue */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventToPass = allEvents[indexPath.row]
        performSegue(withIdentifier: "toDetails", sender: self)
    }
    
    /* sets each row to be 1/10 of frame view */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 10
    }
    
}
