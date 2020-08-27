//
//  WeaatherManager.swift
//  Clima
//
//  Created by halil ibrahim baykan on 26/08/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

class WeatherManager {
    let baseURL = "https://openweathermap.org/data/2.5/weather?appid=439d4b804bc8187953eb36d2a8c26a02&q"
    
    
    func fetchWeatherData(cityName:String){
        let url = "\(baseURL)&q=\(cityName)"
        let url2 = URL(string: url)!
        
        let session = URLSession.shared
        let task = session.dataTask(with: url2) { (data, response, error) in
            let safeData = data {
                
            }
        }
    }
    
}
