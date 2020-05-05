//
//  ImageProperties.swift
//  GET-POST-request
//
//  Created by Павел Алешин on 27.04.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit

struct ImageProperties {
    let key: String
    let data: Data
    
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        guard  let data = image.pngData() else { return nil }
        self.data = data 
        
    }
}
    