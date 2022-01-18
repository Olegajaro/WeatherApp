//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Олег Федоров on 12.10.2021.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    @IBOutlet var weatherIconImageView: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var feelsLikeTempLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    
    private var networking = NetworkManager.shared
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        return locationManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchWeather()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
    }
    
    @IBAction func searchPressed() {
        self.pressedSearchAlertController(
            withTitle: "Enter city name",
            message: nil,
            style: .alert
        ) { [unowned self] city in
            self.networking.fetchCurrentWeather(forRequestType: .cityName(city: city))
        }
    }
    
    private func fetchWeather() {
        networking.onCompletion = { [weak self] currentWeather in
            guard let self = self else { return }
            self.updateInterface(weather: currentWeather)
        }
        
//        networking.fetchCurrentWeather(forRequestType: .cityName(city: "Moscow"))
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

// MARK: - CLLocationManagerDelegate
extension MainViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        networking.fetchCurrentWeather(forRequestType: .coordinate(
            latitude: latitude,
            longitude: longitude
        ))
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
