//
//  APIManager.swift
//  WeatherApp
//
//  Created by Павел Алешин on 06.04.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import Foundation

typealias JSONTask = URLSessionDataTask
typealias JSONComplitionHandler = ([String: AnyObject]?, HTTPURLResponse?, Error?) -> Void

protocol JSONDecodable {
    init?(JSON: [String: AnyObject])
}

enum APIResult<T> {
    case Success(T)
    case Failure(Error)
}

protocol FinalUrlPoint {
    var baseURL: URL { get }
    var path: String { get }
    var request: URLRequest { get }
}

protocol APIManager {
    var sessinonConfiguration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
    func JSONTaskWith(requets: URLRequest, comlitionHandler: @escaping JSONComplitionHandler) -> JSONTask
    func fetch<T>(request: URLRequest, parse: @escaping ([String: AnyObject]) -> T?, complitionHandler: @escaping (APIResult<T>) -> Void)
    
}

extension APIManager {
    
    func JSONTaskWith(requets: URLRequest, comlitionHandler: @escaping JSONComplitionHandler) -> JSONTask {
        
        let dataTask = session.dataTask(with: requets) { (data, response, error) in
            guard let HTTPResponse = response as? HTTPURLResponse else {
                let userInfo = [
                    NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")
                ]
                let error = NSError(domain: PTMNetworkingErrorDomain, code: 100, userInfo: userInfo)
                
                comlitionHandler(nil, nil, error)
                return
            }
            if data == nil {
                if let error = error {
                    comlitionHandler(nil, HTTPResponse, error)
                }
            } else {
                switch HTTPResponse.statusCode {
                case 200:
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                        comlitionHandler(json, HTTPResponse, nil)
                    } catch let error as NSError {
                        comlitionHandler(nil, HTTPResponse, error)
                    }
                default:
                    print("We have got response status: \(HTTPResponse.statusCode)")
                }
            }
        }
        return dataTask
    }
    
    func fetch<T>(request: URLRequest, parse: @escaping ([String: AnyObject]) -> T?, complitionHandler: @escaping (APIResult<T>) -> Void) {
        let dataTask = JSONTaskWith(requets: request) { (json, response, error) in
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        complitionHandler(.Failure(error))
                    }
                    return
                }
                
                if let value = parse(json) {
                    complitionHandler(.Success(value))
                } else {
                    let error = NSError(domain: PTMNetworkingErrorDomain, code: 200, userInfo: nil)
                    complitionHandler(.Failure(error))
                }
            }
        }
        dataTask.resume()
    }
}
