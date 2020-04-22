//
//  User.swift
//  FireBasApp
//
//  Created by Павел Алешин on 20.04.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import Foundation
import Firebase


struct User {
    let uid: String
    let email: String
    
    init(user: Firebase.User) {
        self.uid = user.uid
        self.email = user.email!
    }
    
}

