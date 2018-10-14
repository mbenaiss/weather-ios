//
//  WeatherModel.swift
//  weather
//
//  Created by Mahmoud BEN AISSA on 11/10/2018.
//  Copyright © 2018 Mahmoud BEN AISSA. All rights reserved.
//

import Foundation
import RealmSwift

class Weather : Object{
    @objc dynamic var city : String = ""
    @objc dynamic var lastSync : Date = Date()
    var forecasts = List<Forecast>()
    
    override static func primaryKey() -> String? {
        return "city"
    }
}

class Forecast :Object{
    @objc dynamic var   temperature : Int = 0
    @objc dynamic var  temperatureMin : Int = 0
    @objc dynamic var  temperatureMax : Int = 0
    @objc dynamic var  date : Date = Date()
    @objc dynamic var   icon : String = ""
}
