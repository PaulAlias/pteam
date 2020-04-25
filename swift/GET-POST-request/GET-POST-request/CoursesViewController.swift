//
//  CoursesViewController.swift
//  GET-POST-request
//
//  Created by Павел Алешин on 24.04.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
    }
    
    func fetchData() {
        
//                let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_course"
//                let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
//                let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_website_description"
                let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields"
        
         guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
             guard let data = data else { return }
            do {
                let webSiteDescription =  try JSONDecoder().decode(WebsiteDescription.self, from: data)
                print(webSiteDescription.courses)
            } catch let error as NSError {
                print("Error serealization json: ", error.localizedDescription)
            }
            
        }.resume()
    }
    


}
