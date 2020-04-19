//
//  APIWeatherManager.swift
//  WeatherApp
//
//  Created by Павел Алешин on 06.04.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import Foundation

struct Coordinates {
    let latitude: Double
    let longitude: Double
    
}

enum ForecastType: FinalUrlPoint {
    var baseURL: URL {
        return URL(string: "https://api.forecast.io/")!
    }
    
    var path: String {
        switch self {
        case .Current(let apiKey, let coordinates):
            return "/forecast/\(apiKey)/\(coordinates.latitude),\(coordinates.longitude)"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)
        return URLRequest(url: url!)
    }
    
    case Current(apiKey: String, coordinates: Coordinates)
    
}

final class APIWeatherManager: APIManager {

    let sessinonConfiguration: URLSessionConfiguration
    lazy var session: URLSession = {
        return URLSession(configuration: self.sessinonConfiguration)
    } ()
    let apiKey: String
    
    init(sessinonConfiguration: URLSessionConfiguration, apiKey: String) {
        self.sessinonConfiguration = sessinonConfiguration
        self.apiKey = apiKey
    }
    
    convenience init(apiKey: String) {
        self.init(sessinonConfiguration: URLSessionConfiguration.default, apiKey: apiKey)
    }
    
    func fetchCurrentWeatherWith(coordinates: Coordinates, completionHandler: @escaping (APIResult<CurrentWeather>) -> Void) {
        let request = ForecastType.Current(apiKey: self.apiKey, coordinates: coordinates).request
        
        fetch(request: request, parse: { (json) -> CurrentWeather? in
            if let dictionary = json["currently"] as? [String: AnyObject] {
                return CurrentWeather(JSON: dictionary)
            } else {
                return nil
            }
        }, complitionHandler: completionHandler)
    }
    
}
