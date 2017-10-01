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

        /* FUNC: fetch data for table view, asynchronously */
        fetchUser {
            self.fetchEvents() {
                DispatchQueue.main.async {
                   self.tableView.reloadData()
                }
            }
        }
    }
    
    /* FUNC: fetch data for updated tableview, asynchronously */
    override func viewWillAppear(_ animated: Bool) {
        fetchUser {
            self.fetchEvents() {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    /* FUNC: fetching current user from firebase */
    func fetchUser(withBlock: @escaping () -> ()) {
        let ref = Database.database().reference()
        let uid = (self.auth.currentUser?.uid)!
        ref.child("Users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            let user = User()
            let userDict = snapshot.value as! [String: Any]!
            user.setValuesForKeys(userDict!)
            self.currentUser = user
        withBlock()
            
        })
    }
    
    /* FUNC: fetching events from firebase */
    func fetchEvents(withBlock: @escaping () -> ()) {
        let ref = Database.database().reference()
        
        ref.child("Events").observe(.childAdded, with: { (snapshot) in
            let eventDict = (snapshot.value as! [String : Any])
            let event = Event(eventDict: eventDict)
            if event.eventName != nil {
                self.allEvents.append(event)
            }
            withBlock()
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func setupNavBar() {
        let logOutButton = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        let newEventButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.compose, target: self, action: #selector(goToNewEvent))
        
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
    
    /* TRANSITION: presents NewEventVC modally */
    func goToNewEvent(sender: UIButton!) {
        let newEvent = self.storyboard?.instantiateViewController(withIdentifier: String(describing: NewEventViewController.self)) as! NewEventViewController
        newEvent.currentUser = currentUser
        present(newEvent, animated: true, completion: nil)
    }


    
    /* Initializing table view, and adding it to view */
    func setupTableView(){
        let statusBarHeight = UIApplication.shared.statusBarFrame.maxY
        tableView = UITableView(frame:
            CGRect(x: 0,
                   y: 0,
                   width: view.frame.width,
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
