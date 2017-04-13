//
//  SnapsViewController.swift
//  SimpleSnapchatClone
//
//  Created by John Crisostomo on 11/04/2017.
//  Copyright © 2017 John Crisostomo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var snaps: [Snap] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        FIRDatabase.database().reference()
            .child("users")
            .child(FIRAuth.auth()!.currentUser!.uid)
            .child("snaps")
            .observe(FIRDataEventType.childAdded, with: {
            (snapshot) in
                let snap = Snap()
                
                snap.imageURL = (snapshot.value as! NSDictionary)["image"] as! String
                snap.from = (snapshot.value as! NSDictionary)["from"] as! String
                snap.imageDescription = (snapshot.value as! NSDictionary)["description"] as! String
                
                print(snap.from)
                
                self.snaps.append(snap)
                
                self.tableView.reloadData()
        })
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        do {
            try FIRAuth.auth()!.signOut()
        } catch {}
        
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        
        performSegue(withIdentifier: "viewSnapSegue", sender: snap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSnapSegue"{
            let nextVC = segue.destination as! ViewSnapViewController
            nextVC.snap = sender as! Snap
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let snap = snaps[indexPath.row]
        
        cell.textLabel?.text = snap.from
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snaps.count
    }
}
