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
        
        networking.fetchCurrentWeather(forCity: "London")
    }
    
    @IBAction func searchPressed() {
        self.pressedSearchAlertController(
            withTitle: "Enter city name",
            message: nil,
            style: .alert
        ) { city in
            self.networking.fetchCurrentWeather(forCity: city)
        }
    }
    
}

