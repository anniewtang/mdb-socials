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
    var loadedEvents = [String: Event]()
    var eventToPass: Event!
    
    /* FIREBASE variables */
    var auth = Auth.auth()
    var storage: StorageReference = Storage.storage().reference()
    var currentUser: User!

    //For sample post
//    let sampleEvent = Event(default: "sample")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavBar()

        /* FUNC: fetch User information, and Events for initial tableview (asynchronously) */
        fetchUser {
            self.fetchEvents() {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    /* FUNC: fetch Events again for updated tableview (asynchronously) */
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    /* UI: setting up the navigation bar */
    func setupNavBar() {
        let logOutButton = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        let newEventButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.compose, target: self, action: #selector(goToNewEvent))
        
        navigationItem.leftBarButtonItem = logOutButton
        navigationItem.rightBarButtonItem = newEventButton
        navigationItem.title = "Feed"
    }
   
    /* UI: initializing table view, and adding it to view */
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
    
}

