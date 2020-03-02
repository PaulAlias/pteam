//
//  MercedesDecorator.swift
//  Decorator
//
//  Created by Павел Алешин on 02/03/2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import Foundation

class MercedesDecorator: MercedesProtocol {
    private let decoratorType: MercedesProtocol
    
    required init(decorator: MercedesProtocol) {
        self.decoratorType = decorator
    }
    
    func getTitle() -> String {
        return decoratorType.getTitle()
    }
    
    func getPrice() -> Double {
        return decoratorType.getPrice()
    }
    
    
}
