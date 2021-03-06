//
//  SignInViewController.swift
//  SimpleSnapchatClone
//
//  Created by John Crisostomo on 11/04/2017.
//  Copyright © 2017 John Crisostomo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func turnUpTapped(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("We tried to sign in")
            if  error != nil {
                print("Hey we have an error: \(error!)")
                
                FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                        print("We tried to create a user")
                    if error != nil {
                        print("Hey we have an error: \(error!)")
                    } else {
                        print("Created user successfully")
                        
                        FIRDatabase.database().reference()
                            .child("users")
                            .child(user!.uid)
                            .child("email")
                            .setValue(user!.email!)
                        
                        self.performSegue(withIdentifier: "signInSegue", sender: nil)
                    }
                })
            } else {
                print("Signed in successfully")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
        })
    }
}

