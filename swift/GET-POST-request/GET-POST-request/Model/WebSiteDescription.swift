//
//  WebSiteDescription.swift
//  GET-POST-request
//
//  Created by Павел Алешин on 25.04.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import Foundation

struct WebsiteDescription: Decodable {
    
    let websiteDescription: String?
    let websiteName: String?
    let courses: [Course]
}
