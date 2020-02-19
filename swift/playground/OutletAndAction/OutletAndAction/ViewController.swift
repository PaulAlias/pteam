//
//  ViewController.swift
//  OutletAndAction
//
//  Created by Павел Алешин on 22/12/2019.
//  Copyright © 2019 Павел Алешин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBAction func changeTextInLable(_ sender: UIButton) {
        label.text = "Hi"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

