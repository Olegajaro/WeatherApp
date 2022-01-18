//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Олег Федоров on 12.10.2021.
//

import Foundation
import CoreLocation

class NetworkManager {
    
    enum RequestType {
        case cityName(city: String)
        case coordinate(latitude: CLLocationDegrees,
                        longitude: CLLocationDegrees)
    }
    
    static let shared = NetworkManager()
    
    var onCompletion: ((CurrentWeather) -> Void)?
    
    private init() {}
    
    func fetchCurrentWeather(forRequestType requestType: RequestType) {
        var urlString = ""
        
        switch requestType {
        case .cityName(let city):
           urlString =
            "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(apiKey)&units=metric"
        case .coordinate(let latitude, let longitude):
            urlString =
            "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&apikey=\(apiKey)&units=metric"
        }
        
        performRequest(withURLString: urlString)
    }
    
    private func performRequest(withURLString urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            if let data = data {
                guard
                    let currentWeather = self.parsJSON(withData: data)
                else { return }
                
                self.onCompletion?(currentWeather)
            }
        }.resume()
    }
    
    private func parsJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
             
            guard
                let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData)
            else { return nil }
            
            return currentWeather
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }
}
