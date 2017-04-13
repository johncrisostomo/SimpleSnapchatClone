//
//  SelectUserViewController.swift
//  SimpleSnapchatClone
//
//  Created by John Crisostomo on 12/04/2017.
//  Copyright © 2017 John Crisostomo. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SelectUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var users: [User] = []
    
    var imageURL = ""
    var descriptionText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        FIRDatabase.database().reference().child("users").observe(FIRDataEventType.childAdded, with: { (snapshot) in
            print(snapshot)
            let user = User()
            
            user.email = (snapshot.value as! NSDictionary)["email"] as! String
            user.uid = snapshot.key
            
            self.users.append(user)
            
            self.tableView.reloadData()
        })
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.email
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = users[indexPath.row]
        
        let snap = [
            "from": FIRAuth.auth()?.currentUser?.email!,
            "description": descriptionText,
            "image": imageURL,
        ]
        
        FIRDatabase.database().reference()
            .child("users")
            .child(selectedUser.uid)
            .child("snaps")
            .childByAutoId()
            .setValue(snap)
        
        navigationController!.popToRootViewController(animated: true)
    }
}
