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
    
    private var CurrentWeather = Weather()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let repo = WeatherRepo()
        repo.getWeather(forCity: "paris") { (Weather) in
            
            if let currentWeather  = Weather{
                self.CurrentWeather = currentWeather
                self.updateUI()
            }else {
                self.ShowAlert()
            }
            
            
        }
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    func updateUI()  {
        
        tableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CurrentWeather.forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nextDays", for: indexPath) as! DayCell
        
        cell.setWeaterDay(temp: CurrentWeather.forecasts[indexPath.row])
        return cell
    }
    
}

