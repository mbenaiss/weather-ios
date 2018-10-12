//
//  WeatherRepo.swift
//  weather
//
//  Created by Mahmoud BEN AISSA on 11/10/2018.
//  Copyright © 2018 Mahmoud BEN AISSA. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON

class WeatherRepo{
    
    private let API_KEY = "b6352b1697f5919b4f0ea88b280cf729"
    private let Base_URL = "https://api.openweathermap.org/data/2.5/forecast"
    
    func  getWeather(forCity city : String,completion: @escaping (Weather) -> Void){
        let params : [String:String] = [ "q": city, "appid":API_KEY]
        
        let wether =  Weather(city: city)
        
        Alamofire.request(Base_URL, method: .get, parameters: params).responseJSON { response in
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                
                for (_,subJson):(String, JSON) in json["list"] {
                    let temp = self.convertToCelsius(subJson["main"]["temp"].doubleValue)
                    let temp_min = self.convertToCelsius(subJson["main"]["temp_min"].doubleValue)
                    let temp_max = self.convertToCelsius(subJson["main"]["temp_max"].doubleValue)
                    let dateTime = Date(timeIntervalSince1970: TimeInterval(subJson["dt"].intValue))
                    let icon = subJson["weather"][0]["icon"].stringValue
                    let t = Temp(temperature: temp, temperatureMin: temp_min, temperatureMax: temp_max, dateTime: dateTime,icon:icon)
                    wether.weather.append(t)
                     completion(wether)
                }
            }else{
                print("\(response.result.error!)")
                  completion(wether)
            }
        }
    }
    
    func convertToCelsius(_ value : Double) -> Int {
        return Int(value -  273.15)
    }
    
    
    
}
