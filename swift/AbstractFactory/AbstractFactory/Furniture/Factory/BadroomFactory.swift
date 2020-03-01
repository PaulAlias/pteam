//
//  BadroomFactory.swift
//  AbstractFactory
//
//  Created by Павел Алешин on 01/03/2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import Foundation

class BadroomFactory: AbstractFactory {
func createChair() -> Chair {
    print("Стул для кухни создан")
    return ChairBadroom()
}

func createSofa() -> Sofa {
    print("Диван для кухни создан")
    return SofaBadroom()
}

func createTable() -> Table {
    print("Стол для кухни создан")
    return TableBadroom()
}
    
}
