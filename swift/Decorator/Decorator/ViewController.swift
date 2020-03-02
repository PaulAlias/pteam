//
//  ViewController.swift
//  Decorator
//
//  Created by Павел Алешин on 02/03/2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var priceLabel: UILabel! {
        didSet {
            priceLabel.text = String(mercedes.getPrice()) + "$"
            
        }
    }
    @IBOutlet weak var typeCarLabel: UILabel! {
        didSet {
            typeCarLabel.text = mercedes.getTitle()
        }
    }
    
    var mercedes: MercedesProtocol = MercedesCLA()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func menuCarSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mercedes = MercedesCLA()
            priceLabel.text = String(mercedes.getPrice()) + "$"
            typeCarLabel.text = mercedes.getTitle()
        case 1:
            mercedes = MercedesCLA()
            mercedes = AlloyWheels(decorator: mercedes)
            priceLabel.text = String(mercedes.getPrice()) + "$"
            typeCarLabel.text = mercedes.getTitle()
        case 2:
            mercedes = MercedesCLA()
            mercedes = PanframeRoof(decorator: mercedes)
            priceLabel.text = String(mercedes.getPrice()) + "$"
            typeCarLabel.text = mercedes.getTitle()
        default:
            break
        }
    }
    
}

