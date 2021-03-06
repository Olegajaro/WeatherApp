//
//  ViewController + AlertController.swift
//  WeatherApp
//
//  Created by Олег Федоров on 12.10.2021.
//

import UIKit

extension MainViewController {
    func pressedSearchAlertController(
        withTitle title: String?,
        message: String?,
        style: UIAlertController.Style,
        completion: @escaping(String) -> Void
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: style
        )
        
        let search = UIAlertAction(title: "Search", style: .default) { action in
            let textField = alert.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completion(city)
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField { textField in
            let cities = [
                "San Francisco", "Moscow", "New York", "Stambul", "London"
            ]
            textField.placeholder = cities.randomElement()
        }
        alert.addAction(search)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}
