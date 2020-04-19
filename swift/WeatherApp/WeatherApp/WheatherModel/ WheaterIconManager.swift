//
//   WheaterIconManager.swift
//  WeatherApp
//
//  Created by Павел Алешин on 05.04.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import Foundation
import UIKit


enum WheaterIconManager: String {
    case ClearDay = "clear-day"
    case ClearNight = "clear-night"
    case Rain = "rain"
    case Snow = "snow"
    case Sleet = "sleet"
    case Wind = "wind"
    case Fog = "fog"
    case Cloudy = "cloudy"
    case PartyCloudyDay = "partly-cloudy-day"
    case PartyCloudyNight = "partly-cloudy-night"
    case UnpredictedIcon = "unpredicted-icon"
    
    init(rawValue: String) {
        switch rawValue {
        case "clear-day":  self = .ClearDay
        case "clear-night": self = .ClearNight
        case "rain": self = .Rain
        case "snow": self = .Snow
        case "sleet": self = .Sleet
        case "wind": self = .Wind
        case "fog": self = .Fog
        case "cloudy": self = .Cloudy
        case "partly-cloudy-day": self = .PartyCloudyDay
        case "partly-cloudy-night": self = .PartyCloudyNight
        default: self = .UnpredictedIcon
        }
    }
}


extension WheaterIconManager {
    var image: UIImage {
        switch WheaterIconManager(rawValue: rawValue) {
        case .ClearDay:  return UIImage(systemName: "sun.max")!
        case .ClearNight: return UIImage(systemName: "sun.max")!
        case .Rain: return UIImage(systemName: "cloud.rain")!
        case .Snow: return UIImage(systemName: "snow")!
        case .Sleet: return UIImage(systemName: "cloud.sleet")!
        case .Wind: return UIImage(systemName: "wind")!
        case .Fog: return UIImage(systemName: "sun.max")!
        case .Cloudy: return UIImage(systemName: "cloud.fill")!
        case .PartyCloudyDay: return UIImage(systemName: "cloud.fill")!
        case .PartyCloudyNight: return UIImage(systemName: "cloud.fill")!
        default: return UIImage(systemName: "thermometer.sun")!
        }
    }
}
