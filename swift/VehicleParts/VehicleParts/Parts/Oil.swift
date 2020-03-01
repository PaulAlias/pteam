//
//  Oil.swift
//  VehicleParts
//
//  Created by Павел Алешин on 01/03/2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import Foundation

class Oil: Part {
    
    var name: String = "Моторное масло"
    
    var price: Int = 2000
    
    func change() {
        print("Замена запчасти \(name)")
    }
    
    func instert() {
        print("Добавлена запчасть \(name)")
    }
    
    
}
