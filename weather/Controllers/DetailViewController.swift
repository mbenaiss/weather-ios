//
//  DetailViewController.swift
//  weather
//
//  Created by Mahmoud BEN AISSA on 11/10/2018.
//  Copyright © 2018 Mahmoud BEN AISSA. All rights reserved.
//
import UIKit

class DetailViewController: UIViewController,UITableViewDataSource  ,UITableViewDelegate {
    
    
    @IBOutlet weak var tableview: UITableView!
    
    private var CurrentWeather = Weather(city: "paris")
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repo = WeatherRepo()
        repo.getWeather(forCity: "paris") { (Weather) in
            
            
            self.CurrentWeather = Weather
            self.updateUI()
        }
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    func updateUI()  {
       
        tableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CurrentWeather.weather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nextDays", for: indexPath) as! DayCell
        
        cell.setWeaterDay(temp: CurrentWeather.weather[indexPath.row])
        return cell
    }
    
}

