//
//  ViewController.swift
//  VehicleParts
//
//  Created by Павел Алешин on 01/03/2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var partArray = [Part]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        create(part: .oil)
        create(part: .plug)
        changePart()
        
    }
    
    func create(part: Parts) {
        let newPart = FactoryParts.defaulFactory.create(part: part)
        partArray.append(newPart)
    }
    
    func changePart() {
        for pt in partArray {
            pt.instert()
            pt.change()
        }
    }

}

