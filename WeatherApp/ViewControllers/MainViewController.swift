//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Олег Федоров on 12.10.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var weatherIconImageView: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var feelsLikeTempLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    
    private var networking = NetworkManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networking.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterface(weather: currentWeather)
        }
        networking.fetchCurrentWeather(forCity: "London")
    }
    
    @IBAction func searchPressed() {
        self.pressedSearchAlertController(
            withTitle: "Enter city name",
            message: nil,
            style: .alert
        ) { [unowned self] city in
            self.networking.fetchCurrentWeather(forCity: city)
        }
    }
    
    private func updateInterface(weather: CurrentWeather) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
            self.feelsLikeTempLabel.text = weather.feelsLikeTemperatureString + "°C"
            self.weatherIconImageView.image = UIImage(systemName: weather.systemIconNameString)
        }
    }
}

