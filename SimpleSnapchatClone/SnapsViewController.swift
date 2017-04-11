//
//  SnapsViewController.swift
//  SimpleSnapchatClone
//
//  Created by John Crisostomo on 11/04/2017.
//  Copyright © 2017 John Crisostomo. All rights reserved.
//

import UIKit

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
