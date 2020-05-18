//
//  UserProfile.swift
//  Networking
//
//  Created by Павел Алешин on 18.05.2020.
//  Copyright © 2020 Alexey Efimov. All rights reserved.
//

import Foundation


struct UserProfile {
    let id: Int?
    let name: String?
    let email: String?
    
    init(data: [String: Any]) {
        let id = data["id"] as? Int
        let name = data["name"] as? String
        let email = data["email"] as? String
        
        self.id = id
        self.name = name
        self.email = email
    }
}
