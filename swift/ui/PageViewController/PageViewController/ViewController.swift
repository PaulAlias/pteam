//
//  ViewController.swift
//  PageViewController
//
//  Created by Павел Алешин on 19/02/2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startPresentation()
    }
    
    func startPresentation(){
        if let pageViewController = storyboard?.instantiateViewController(
            identifier: "PageViewController") as? PageViewController {
            
            present(pageViewController, animated: true, completion: nil)
        }
    }

}

