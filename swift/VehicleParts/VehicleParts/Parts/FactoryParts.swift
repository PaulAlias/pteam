 //
//  FactoryParts.swift
//  VehicleParts
//
//  Created by Павел Алешин on 01/03/2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import Foundation
 
 enum Parts {
    case plug, oil
 }
 
 class FactoryParts {
    static let defaulFactory = FactoryParts()
    
    func create(part: Parts) -> Part {
        switch part {
        case .plug: return SparkPlug()
        case .oil: return Oil()
        }
    }
 }
