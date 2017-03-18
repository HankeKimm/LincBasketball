//
//  ViewController.swift
//  LincBasketball
//
//  Created by hanke.kimm on 3/16/17.
//  Copyright © 2017 Hanke Kimm. All rights reserved.
//

import UIKit
import FacebookLogin
import FirebaseAuth

class ViewController: UIViewController, LoginButtonDelegate {
    
    var currentUser : FIRUser?

    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
        loginButton.delegate = self
    }

    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .cancelled:
            break
        case .success(_, _, let accessToken):
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken)
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                if let error = error {
                    print(error)
                }
                print("Success")
                self.currentUser = user
            }
        default: break
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

