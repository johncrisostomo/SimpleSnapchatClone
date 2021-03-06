//
//  ViewSnapViewController.swift
//  SimpleSnapchatClone
//
//  Created by John Crisostomo on 12/04/2017.
//  Copyright © 2017 John Crisostomo. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class ViewSnapViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var snap = Snap()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        descriptionLabel.text! = snap.imageDescription
        imageView.sd_setImage(with: URL(string: snap.imageURL))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        FIRDatabase.database().reference()
            .child("users")
            .child(FIRAuth.auth()!.currentUser!.uid)
            .child("snaps")
            .child(snap.key)
            .removeValue()
        
        FIRStorage.storage().reference().child("images")
            .child("\(snap.uuid).jpg")
            .delete(completion: {
                (error) in
                if error != nil {
                    print(error!)
                }
                
            })
    }
}
