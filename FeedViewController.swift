//
//  FeedViewController
//  mdb-socials
//
//  Created by Annie Tang on 9/26/17.
//  Copyright © 2017 Annie Tang. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController {
    
    /* UI elements */
    var tableView: UITableView!
    
    /* SWIFT data */
    var allEvents = [Event]()
    var eventToPass: Event!
    
    /* FIREBASE variables */
    var auth = Auth.auth()
    var storage: StorageReference = Storage.storage().reference()
    var currentUser: User?

    //For sample post
    let sampleEvent = Event()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        allEvents.append(sampleEvent)
        allEvents.append(sampleEvent)
        allEvents.append(sampleEvent)
        allEvents.append(sampleEvent)
        
        setupTableView()
        setupNavBar()

        /* FUNC: set up UI for current user */
        fetchUser {
            self.fetchEvents() {
                
                self.setupTableView()
                self.setupNavBar()
                
//                activityIndicator.stopAnimating()
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func setupNavBar() {
        let logOutButton = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        let newEventButton = UIBarButtonItem(title: "Create Event", style: .plain, target: self, action: #selector(goToNewEvent))
        
        navigationItem.leftBarButtonItem = logOutButton
        navigationItem.rightBarButtonItem = newEventButton
        navigationItem.title = "Feed"
    }
    
    func logOut() {
        print("Logging out.")
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    /* presents NewEventVC modally */
    func goToNewEvent(sender: UIButton!) {
        performSegue(withIdentifier: "segueToNewEvents", sender: self)
        
        
//        let newEvent = self.storyboard?.instantiateViewController(withIdentifier: String(describing: NewEventViewController.self)) as! NewEventViewController
//        newEvent.delegate = self
//        newEvent.currentUser = currentUser
//        self.present(newEvent, animated: true, completion: nil)
    }
    
    /* protocol to present NewEventVC modally */
    func dismissViewController() {
        if let viewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing: FeedViewController())){
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    /* fetching events from firebase */
    func fetchEvents(withBlock: @escaping () -> ()) {
        let ref = Database.database().reference()
        ref.child("Events").observe(.childAdded, with: { (snapshot) in
            let event = Event(id: snapshot.key, eventDict: snapshot.value as! [String : Any]?)
//            self.allEvents.append(event)
            
            withBlock()
        })
    }
    
    /* fetching current user from firebase */
    func fetchUser(withBlock: @escaping () -> ()) {
        let ref = Database.database().reference()
        ref.child("Users").child((self.auth.currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            let user = User(id: snapshot.key, userDict: snapshot.value as! [String : Any]?)
            self.currentUser = user
            withBlock()
            
        })
    }

    
    /* Initializing table view, and adding it to view */
    func setupTableView(){
        let navigationBarHeight = self.navigationController?.navigationBar.frame.height ?? 0
        let statusBarHeight = UIApplication.shared.statusBarFrame.maxY
        tableView = UITableView(frame:
            CGRect(x: 0,
                   y: navigationBarHeight + statusBarHeight,                   width: view.frame.width,
                   height: view.frame.height - statusBarHeight))
        
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
        cell.creatorName.text = "By: " + event.creator!
        cell.eventName.text = event.eventName
        Utils.getImage(url: event.imageUrl!) { img in
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
    
    /* action after tableCell is selected
     "passes" the event object over into the DetailsVC through segue */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        eventToPass = allEvents[indexPath.row]
        performSegue(withIdentifier: "toDetails", sender: self)
    }
    
    /* sets each row to be 1/10 of frame view */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 5
    }
    
}
