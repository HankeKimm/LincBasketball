//
//  ViewController.swift
//  LincBasketball
//
//  Created by hanke.kimm on 3/16/17.
//  Copyright © 2017 Hanke Kimm. All rights reserved.
//

import UIKit
import FacebookLogin
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController, LoginButtonDelegate {
    
    var ref: FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        let loginButton = LoginButton(readPermissions: [ .publicProfile])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
        loginButton.delegate = self
    }

    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .cancelled:
            print("Login cancelled")
        case .success(let grantedPermissions, _, let accessToken):
            print(grantedPermissions)
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                if let error = error {
                    print(error)
                }
                print("Success")
                let userData = [
                    "uid": user?.uid,
                    "displayName": user?.displayName,
                    "photoURL": user?.photoURL?.absoluteString
                ]
                self.ref.child("users").child(user!.uid).setValue(userData)
            }
        default:
            break
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

