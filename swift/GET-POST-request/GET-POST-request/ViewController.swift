//
//  ViewController.swift
//  GET-POST-request
//
//  Created by Павел Алешин on 24.04.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var ourCourses: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func getAction(_ sender: UIButton) {
         guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let session = URLSession.shared
        //для того что бы вызвать сессию надо вызвать .resume
        session.dataTask(with: url) { (data, response, error) in
             guard let response = response, let data = data  else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    @IBAction func postAction(_ sender: UIButton) {
         guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        let userData = ["Course": "Network", "lesson": "get and post"]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
         guard let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: []) else { return }
        
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
             guard let response = response, let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
               //print(json)
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
}

