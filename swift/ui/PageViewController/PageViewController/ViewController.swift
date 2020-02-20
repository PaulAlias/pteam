//
//  ViewController.swift
//  PageViewController
//
//  Created by Павел Алешин on 19/02/2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        //при любом запуске обнуляет значение просмотре презентации
        UserDefaults.standard.set(false, forKey: "presentationWasViewed")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startPresentation()
       
    }
    
    func startPresentation(){
        
       let userDefaults = UserDefaults.standard
       let presentationWasViewed = userDefaults.bool(forKey: "presentationWasViewed")
  
        
        if presentationWasViewed == false {
            if let pageViewController = storyboard?.instantiateViewController(
                identifier: "PageViewController") as? PageViewController {
                present(pageViewController, animated: true, completion: nil)
            }
        }
        
        

    }

}

