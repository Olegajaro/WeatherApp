//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Олег Федоров on 12.10.2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCurrentWeather(forCity city: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)"
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            if let data = data {
                guard let dataString = String(data: data, encoding: .utf8) else { return }
                print(dataString)
            }
        }.resume()
    }
}
