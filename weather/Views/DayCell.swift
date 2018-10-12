//
//  DayCell.swift
//  weather
//
//  Created by Mahmoud BEN AISSA on 11/10/2018.
//  Copyright © 2018 Mahmoud BEN AISSA. All rights reserved.
//

import UIKit

class DayCell: UITableViewCell{
    
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var max: UILabel!
    @IBOutlet weak var min: UILabel!
    
    func setWeaterDay(temp :Forecast) {
        day.text = temp.dayOfWeek
        max.text = String(temp.temperatureMax)
        min.text = String(temp.temperatureMin)
    }
}
