//
//  AlloyWheels.swift
//  Decorator
//
//  Created by Павел Алешин on 02/03/2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import Foundation

class AlloyWheels: MercedesDecorator {
    required init(decorator: MercedesProtocol) {
        super.init(decorator: decorator)
    }
    
    override func getTitle() -> String {
        return super.getTitle() + " premium wheels"
    }
    
    override func getPrice() -> Double {
        return super.getPrice() + 1500
    }
}
