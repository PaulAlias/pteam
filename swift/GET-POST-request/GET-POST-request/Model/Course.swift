//
//  Course.swift
//  GET-POST-request
//
//  Created by Павел Алешин on 24.04.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import Foundation

struct Course: Decodable {
    
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
}
