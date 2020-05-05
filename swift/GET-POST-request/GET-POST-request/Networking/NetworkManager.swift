//
//  NetworkManager.swift
//  GET-POST-request
//
//  Created by Павел Алешин on 26.04.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
// json link
//"https://jsonplaceholder.typicode.com/posts"
//"https://swiftbook.ru//wp-content/uploads/api/api_course"
//"https://swiftbook.ru//wp-content/uploads/api/api_courses"
//"https://swiftbook.ru//wp-content/uploads/api/api_website_description"
//"https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields"


import UIKit


class NetworkManager {
    //static методы можно вызывать не создавая экземпляр класса
    
    static func getRequest(url: String) {
        
        
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared
        //для того что бы вызвать сессию надо вызвать .resume
        session.dataTask(with: url) { (data, response, error) in
            guard let response = response, let data = data  else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    static func postRequest(url: String) {
        guard let url = URL(string: url) else { return }
        
        let userData = ["Course": "Network", "lesson": "get and post"]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: []) else { return }
        
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let response = response, let data = data else { return }
            print(response)
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    static func downloadData(url: String, completion: @escaping (_ image: UIImage)->()) {
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            }
            
        }.resume()
    }
    
    static func fetchData(url: String, completion: @escaping (_ courses: [Course])->()) {
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let courses = try decoder.decode([Course].self, from: data)
                completion(courses)
            } catch let error {
                print("Error serialization json", error)
            }
            
        }.resume()
    }
    
    static func uploadImage(url: String) {
        let image = UIImage(named: "pic")!
        var httpHeaders = ["Authorization": "Client-ID e98b939a437c005"]
         guard let imageProperties = ImageProperties(withImage: image, forKey: "image") else { return }
         guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = httpHeaders
        
        request.httpBody = imageProperties.data
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response { print(response) }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch let error as NSError {
                    print(error.localizedDescription)
                }
            }
        }.resume()
        
        
    }
}

