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
    
    
    let dateFormatter = DateFormatter()
    
    func setWeaterDay(temp :Temp) {
        
        dateFormatter.locale =  Locale(identifier: "fr_FR")
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE hh:mm")
        day.text = dateFormatter.string(from:   temp.dateTime)
        max.text = String(temp.temperatureMax)
        min.text = String(temp.temperatureMin)
        
    }
}
