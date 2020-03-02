//
//  PanframeRoof.swift
//  Decorator
//
//  Created by Павел Алешин on 02/03/2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import Foundation

class PanframeRoof: MercedesDecorator {
    required init(decorator: MercedesProtocol) {
        super.init(decorator: decorator)
    }
    
    override func getTitle() -> String {
        return super.getTitle() + " premium roof"
    }
    
    override func getPrice() -> Double {
        return super.getPrice() + 2000
    }
}
