//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Павел Алешин on 05.04.2020.
//  Copyright © 2020 Павел Алешин. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
    let temperature: Double
    let apparentTemperature: Double
    let humididy: Double
    let pressure: Double
    let icon: UIImage
}

extension CurrentWeather: JSONDecodable {
    init?(JSON: [String : AnyObject]) {
        guard let temperature = JSON["temperature"] as? Double,
        let apparentTemperature = JSON["apparentTemperature"] as? Double,
        let humididy = JSON["humididy"] as? Double,
        let pressure = JSON["pressure"] as? Double,
            let iconString = JSON["icon"] as? String else {
                return nil
        }
        let icon = WheaterIconManager(rawValue: iconString).image
        
        self.temperature = temperature
        self.apparentTemperature = apparentTemperature
        self.humididy = humididy
        self.pressure = pressure
        self.icon = icon
    }
    
}

extension CurrentWeather {
    var pressureString: String {
        return " \(Int(pressure)) мм"
    }
    var humidityString: String {
        return " \(Int(humididy)) %"
    }
    var temperatureString: String {
        return "\(Int(temperature))˚C"
    }
    var apparentTemperatureString: String {
        return " Ощущается как \(Int(apparentTemperature))˚C"
    }
    
}
