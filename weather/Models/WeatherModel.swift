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
    var weather : [Temp] = []
 
    init(city:String) {
        self.city = city
    }
}

struct Temp {
    let temperature : Int
    let temperatureMin : Int
    let temperatureMax : Int
    let dateTime : Date
    let icon : String
}
