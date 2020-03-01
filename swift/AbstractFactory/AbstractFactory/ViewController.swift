//
//  ViewController.swift
//  AbstractFactory
//
//  Created by Павел Алешин on 01/03/2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var chair: Chair?
    var table: Table?
    var sofa: Sofa?
    
    @IBOutlet weak var textKitchen: UILabel!
    @IBOutlet weak var textBadroom: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func sendKitchen(_ sender: UIButton) {
        chair = KitchenFactory().createChair()
        table = KitchenFactory().createTable()
        sofa = KitchenFactory().createSofa()
        textKitchen.text = "Созданы: \(chair!.type), \(table!.type), \(sofa!.type)"
     
        
    }
    
    @IBAction func sendBadroom(_ sender: UIButton) {
        chair = BadroomFactory().createChair()
        table = BadroomFactory().createTable()
        sofa = BadroomFactory().createSofa()
        textBadroom.text = "Созданы: \(chair!.type), \(table!.type), \(sofa!.type)"
    }
      
}

