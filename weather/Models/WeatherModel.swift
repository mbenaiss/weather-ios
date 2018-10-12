//
//  WeatherModel.swift
//  weather
//
//  Created by Mahmoud BEN AISSA on 11/10/2018.
//  Copyright © 2018 Mahmoud BEN AISSA. All rights reserved.
//

import Foundation

class Weather{
    var city : String
    var weather : Array<Forecast> = []
 
    init(city:String) {
        self.city = city
    }
}

class Forecast {
    var temperature : Int = 0
    var temperatureMin : Int = 0
    var temperatureMax : Int = 0
    var dateTime : Date = Date.init()
    var formatDate : String = ""
    var dayOfWeek:String = ""
    var icon : String = ""
    
}
