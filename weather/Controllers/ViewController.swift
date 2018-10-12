//
//  ViewController.swift
//  weather
//
//  Created by Mahmoud BEN AISSA on 11/10/2018.
//  Copyright © 2018 Mahmoud BEN AISSA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var CurrentWeather = Weather(city: "paris")
    
    @IBOutlet weak var tempLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repo = WeatherRepo()
        repo.getWeather(forCity: "paris") { (Weather) in
            self.CurrentWeather = Weather
            self.updateUI()
        }
    }
    
    func updateUI()  {
        self.tempLabel.text = "\(CurrentWeather.weather[0].temperature) °"
    }
}

