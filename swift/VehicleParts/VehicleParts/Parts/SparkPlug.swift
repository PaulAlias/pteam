//
//  SparkPlug.swift
//  VehicleParts
//
//  Created by Павел Алешин on 01/03/2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import Foundation

class SparkPlug: Part {
    
    var name: String = "Свеча зажигания"
    var price: Int = 500
    
    func change() {
        print("Замена запчасти \(name)")
    }
    
    func instert() {
        print("Добавлена запчасть \(name)")
    }
     
}
