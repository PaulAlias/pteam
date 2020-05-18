//
//  AlamofireNetworkRequest.swift
//  Networking
//
//  Created by Павел Алешин on 13.05.2020.
//

import Foundation
import Alamofire

class AlamofireNetworkRequest {
    
    static var onProgress: ((Double) -> ())?
    static var completed: ((String) -> ())?
    
    static func sendRequest(url: String, completion: @escaping (_ courses: [Course])->()) {
        
        guard let url = URL(string: url) else { return }
        
        //        старый метод
        //        request(url).responseJSON { (response) in
        //
        //            guard let statusCode = response.response?.statusCode else { return }
        //
        //            print("statusCode: ", statusCode)
        //
        //            //если статус от 200 до 299 то это не ошибка
        //            if (200..<300).contains(statusCode) {
        //                //создаем значение value и присваиваем ему значение полученное от сервера(response)
        //                let value = response.result.value
        //                print("value: ", value ?? "nil")
        //            } else {
        //                let error = response.result.error
        //                print(error ?? "error")
        //            }
        //
        //        }
        
        request(url).validate().responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                //print(arrayOfItems)
                var courses = [Course]()
                courses = Course.getArray(from: value)!
                completion(courses)
                
            case .failure(let error):
                print(error)
            }
            
            
        }
        
        
        
        
    }
    
    static func responseData(url: String) {
        request(url).responseData { (responseData) in
            
            switch responseData.result {
            case .success(let data):
                guard let string = String(data: data, encoding: .utf8) else { return }
                print(string)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    static func responseString(url: String) {
        request(url).responseString { (responseString) in
            
            switch responseString.result {
            case .success(let string):
                print(string)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func response(url: String){
        
        request(url).response { (response) in
            
            guard let data = response.data, let string = String(data: data, encoding: .utf8) else { return }
            
            print(string)
            
            
            
        }
        
    }
    
    static func downloadImage(url: String, completion: @escaping (_ image: UIImage) -> ()) {
        guard let url = URL(string: url) else { return }
        request(url).responseData { (responseData) in
            switch responseData.result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                completion(image)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func downloadImageWithProgress(url: String, completion: @escaping (_ image: UIImage) -> ()) {
        
        guard let url = URL(string: url) else { return }
        
        request(url).validate().downloadProgress { (progress) in
            print("totalUnitCount: \(progress.totalUnitCount) \n")
            print("completedUnitCount: \(progress.completedUnitCount) \n")
            print("fractionCompleted: \(progress.fractionCompleted) \n")
            print("localizedDescription: \(progress.localizedDescription!) \n")
            print("localizedAdditionalDescription: \(progress.localizedAdditionalDescription!) \n")
            print("----------------------------------------------------------")
            
            self.onProgress?(progress.fractionCompleted)
            self.completed?(progress.localizedDescription)
        }.response { (response) in
            guard let data = response.data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    static func postRequest(url: String, completion: @escaping (_ courses: [Course])->()) {
        
        guard let url = URL(string: url) else { return }
        
        let userData: [String: Any] = [
            "name":"Network Request",
            "link":"https://swiftbook.ru/contents/our-first-application/",
            "imageUrl":"https://swiftbook.ru/wp-content/uploads/2018/03/3-courselogo-1.jpg",
            "number_of_lessons":18,
            "number_of_tests": 10 ]
        
        request(url, method: .post, parameters: userData).responseJSON { (responseJson) in
            
            guard let statusCode = responseJson.response?.statusCode else { return }
            
            print("status code: ", statusCode)
            
            switch responseJson.result {
            case .success(let value):
                print(value)
                
                guard let jsonObject = value as? [String: Any], let course = Course(json: jsonObject) else { return }
                
                var courses = [Course]()
                
                courses.append(course)
                
                completion(courses)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func putRequest(url: String, completion: @escaping (_ courses: [Course])->()) {
        
        guard let url = URL(string: url) else { return }
        
        let userData: [String: Any] = [
            "name":"Network Request with Alamofire",
            "link":"https://swiftbook.ru/contents/our-first-application/",
            "imageUrl":"https://swiftbook.ru/wp-content/uploads/2018/03/3-courselogo-1.jpg",
            "number_of_lessons":18,
            "number_of_tests": 10 ]
        
        request(url, method: .put, parameters: userData).responseJSON { (responseJson) in
            
            guard let statusCode = responseJson.response?.statusCode else { return }
            
            print("status code: ", statusCode)
            
            switch responseJson.result {
            case .success(let value):
                print(value)
                
                guard let jsonObject = value as? [String: Any], let course = Course(json: jsonObject) else { return }
                
                var courses = [Course]()
                
                courses.append(course)
                
                completion(courses)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func uploadImage(url: String) {
        
        guard let url = URL(string: url) else { return }
        
        let image = UIImage(named: "Notification")!
        let data = image.pngData()!
        
        let httpHeaders = ["Authorization": "Client-ID 1bd22b9ce396a4c"]
        
        upload(multipartFormData: { (multipartFormData) in
            //кодируем данные на лету в памяти устройства
            //multipartFormData предназначен для создания данных из составных частей
            //для последующей передачи данных по протоколу http
            //данный способ не подходит для выгрузки видео контента
            multipartFormData.append(data, withName: "image")
        }, to: url, headers: httpHeaders) { (encodingCompletion) in
            
            switch encodingCompletion {
            case .success(request: let uploadRequest, streamingFromDisk: let streamingFromDisk, streamFileURL: let streamFileURL):
                print(uploadRequest)
                print(streamingFromDisk)
                print(streamFileURL ?? "streamFileURL nil")
                
                uploadRequest.validate().responseJSON { (responseJson) in
                    
                    switch responseJson.result {
                    case .success(let value):
                        print(value)
                    case .failure(let error):
                        print(error)
                    }
                    
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
}
