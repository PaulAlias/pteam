//
//  Task.swift
//  TodoApp
//
//  Created by Павел Алешин on 22.05.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import Foundation

struct Task {
    let title: String
    let description: String?
    let date: Date
    let location: Location?

    init(title: String, date: Date? = nil, description: String? = nil, location: Location? = nil) {
        self.location = location
        self.title = title
        self.description = description
        self.date = date ?? Date()
    }
}


extension Task: Equatable {
    static func ==(lhs: Task, rhs: Task) -> Bool {
        if lhs.title == rhs.title,
            lhs.description == rhs.description,
            lhs.location == rhs.location {
            
            return true
        }
        
        return false
    }
    
}
