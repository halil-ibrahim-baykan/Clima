//
//  WeaatherManager.swift
//  Clima
//
//  Created by halil ibrahim baykan on 26/08/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
   func didUpdateWeather(weather: WeatherModel)
}

class WeatherManager {
    let weatherURL = "https://openweathermap.org/data/2.5/weather?appid=439d4b804bc8187953eb36d2a8c26a02&units=metric"
    
    var  delegate : WeatherManagerDelegate?
    
     func fetchWeatherData(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        self.performRequest(urlString: urlString)
    
    }
    
    func performRequest(urlString: String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                if let safeData = data {
                    
                    
                    if let weather = self.parseJson(weatherData: safeData){
                    
                        self.delegate?.didUpdateWeather(weather: weather)
             
                    }
                    
                }
                
            }
            
            task.resume()
            
        }
 
    }
    
    func parseJson(weatherData: Data) -> WeatherModel? {
        
//        let decoder = try? JSONDecoder().decode(WeatherData.self, from: weatherData)
        
        do {
           let decodedData = try JSONDecoder().decode(WeatherData.self, from: weatherData)
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
//            let weather = WeatherModel(conditionId: id, cityName: name, temprature: temp)
            let weather = WeatherModel(id: id, city: name, temp: temp)
            return weather
        } catch  {
            print(error)
            return nil
        }
        
    }
    
    
    
    
}
