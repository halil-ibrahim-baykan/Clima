//
//  ViewController.swift
//  Clima
//
//  Created by halil ibrahim baykan on 21/08/2020.
//  Copyright © 2020 halil ibrahim baykan. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
  
    

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherManager.delegate = self
        searchTextField.delegate = self
        
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        
        searchTextField.endEditing(true)
        
        guard let city = searchTextField.text else {return}
        weatherManager.fetchWeatherData(cityName: city)
 
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        <#code#>
//    }
    
    
    func didUpdateWeather(weather: WeatherModel) {
        
        DispatchQueue.main.async {
            if let image = UIImage(systemName: weather.conditionString){
                self.conditionImageView.image = image
            }
            
            self.temperatureLabel.text = weather.tempString
            self.cityLabel.text = weather.city
            
            
            
        }
        
    }
    
    
    
}

