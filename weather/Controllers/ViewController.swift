//
//  ViewController.swift
//  weather
//
//  Created by Mahmoud BEN AISSA on 11/10/2018.
//  Copyright © 2018 Mahmoud BEN AISSA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var grouped : Array<Forecast> = []
    private let city = "paris"
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    @IBOutlet weak var day1: UILabel!
    @IBOutlet weak var icon1: UIImageView!
    @IBOutlet weak var temp1: UILabel!
    
    @IBOutlet weak var day2: UILabel!
    @IBOutlet weak var icon2: UIImageView!
    @IBOutlet weak var temp2: UILabel!
    
    @IBOutlet weak var day3: UILabel!
    @IBOutlet weak var icon3: UIImageView!
    @IBOutlet weak var temp3: UILabel!
    
    @IBOutlet weak var day4: UILabel!
    @IBOutlet weak var icon4: UIImageView!
    @IBOutlet weak var temp4: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repo = WeatherRepo()
        repo.getWeather(forCity: city) { (Weather) in
            if let currentWeather = Weather {
                self.grouped = repo.groupByDay(from: currentWeather)
                self.updateUI()
            }
            else{
                self.ShowAlert()
            }
            
        }
    }
    
    func updateUI()  {
        
        if grouped.count > 4 {
            
            tempLabel.text = "\(grouped[0].temperature) °"
            dayLabel.text = grouped[0].date.dayName(ofStyle: .full)
            cityLabel.text = city
            
            
            
            day1.text = grouped[1].date.dayName(ofStyle: .threeLetters)
            icon1.image = UIImage(named: grouped[1].icon)
            temp1.text = "\(grouped[1].temperature) °"
            
            day2.text = grouped[2].date.dayName(ofStyle: .threeLetters)
            icon2.image = UIImage(named: grouped[2].icon)
            temp2.text = "\(grouped[2].temperature) °"
            
            day3.text = grouped[3].date.dayName(ofStyle: .threeLetters)
            icon3.image = UIImage(named: grouped[3].icon)
            temp3.text = "\(grouped[3].temperature) °"
            
            day4.text = grouped[4].date.dayName(ofStyle: .threeLetters)
            icon4.image = UIImage(named: grouped[4].icon)
            temp4.text = "\(grouped[4].temperature) °"
            
            
            
        }
    }
}

