//
//  WeaatherManager.swift
//  Clima
//
//  Created by halil ibrahim baykan on 26/08/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
   func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

class WeatherManager {
    let weatherURL = "https://openweathermap.org/data/2.5/weather?appid=439d4b804bc8187953eb36d2a8c26a02&units=metric"
    
    var  delegate : WeatherManagerDelegate?
    
     func fetchWeatherDataWithCity(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        self.performRequest(with: urlString)
    
    }
    
    func fetchWeatherDataWithLocation(lat: Double, lon: Double) {
         let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
         self.performRequest(with: urlString)
     
     }
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    self.delegate?.didFailWithError(error: error)
                    return
                }
                if let safeData = data {
            
                    if let weather = self.parseJson(safeData){
                    
                        self.delegate?.didUpdateWeather(self, weather: weather)
             
                    }
                    
                }
                
            }
            
            task.resume()
            
        }
 
    }
    
    func parseJson(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
           let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temprature: temp)
            return weather
            
        } catch  {
            delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
    
    
    
    
}
