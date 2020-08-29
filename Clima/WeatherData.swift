//
//  WeatherData.swift
//  Clima
//
//  Created by halil ibrahim baykan on 27/08/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let id: Int
//    let timezone: Int
//    let cod: Int
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}
struct Weather: Codable {
    let description: String
    let id: Int
}
