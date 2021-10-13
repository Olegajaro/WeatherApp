//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Олег Федоров on 12.10.2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    var onCompletion: ((CurrentWeather) -> Void)?
    
    private init() {}
    
    func fetchCurrentWeather(forCity city: String ) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            if let data = data {
                guard let currentWeather = self.parsJSON(withData: data) else { return }
                self.onCompletion?(currentWeather)
            }
        }.resume()
    }
    
    func parsJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return nil }
            return currentWeather
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
}
