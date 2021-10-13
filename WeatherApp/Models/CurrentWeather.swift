//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Олег Федоров on 13.10.2021.
//

import Foundation

struct CurrentWeather {
    let cityName: String
    let temperature: Double
    let feelsLikeTemperature: Double
    let conditionCode: Int
    
    var temperatureString: String {
        "\(temperature.rounded())"
    }
    var feelsLikeTemperatureString: String {
        "\(feelsLikeTemperature.rounded())"
    }
    
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLikeTemperature = currentWeatherData.main.feelsLike
        conditionCode = currentWeatherData.weather.first?.id
    }
}
