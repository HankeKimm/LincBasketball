//
//  LincBallUser.swift
//  LincBasketball
//
//  Created by hanke.kimm on 3/17/17.
//  Copyright © 2017 Hanke Kimm. All rights reserved.
//

import Foundation
import FirebaseAuth

class LincBallUser {
    
    let userData : [String : String]
    
    init(firUser: FIRUser) {
        self.userData = [
            "uid": firUser.uid,
            "displayName": firUser.displayName!,
            //"email": firUser.providerData,
            "photoURL": (firUser.photoURL?.absoluteString)!
        ]
    }
}
