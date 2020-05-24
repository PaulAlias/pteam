//
//  Location.swift
//  TodoApp
//
//  Created by Павел Алешин on 22.05.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    let name: String
    let coordinate: CLLocationCoordinate2D?
    
    init(name: String, coordinate: CLLocationCoordinate2D? = nil) {
        self.name = name
        self.coordinate = coordinate
    }
}


extension Location: Equatable {
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        guard rhs.coordinate?.latitude == lhs.coordinate?.latitude
            && rhs.coordinate?.longitude == lhs.coordinate?.longitude
            && lhs.name == rhs.name
        else { return false }
        return true
    }
}






















