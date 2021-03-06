//
//  AbstractFactory.swift
//  AbstractFactory
//
//  Created by Павел Алешин on 01/03/2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import Foundation

protocol AbstractFactory {
    
    func createChair() -> Chair
    func createSofa() -> Sofa
    func createTable() -> Table
    
}
