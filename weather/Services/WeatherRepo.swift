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
import SwifterSwift
import RealmSwift

class WeatherRepo{
    
    private let API_KEY = "b6352b1697f5919b4f0ea88b280cf729"
    private let Base_URL = "https://api.openweathermap.org/data/2.5/forecast"
    
    let Db = RealmDB()
    
    func saveWeather(weather : Weather){
        Db.save(data: weather)
    }
    
    func  getWeather(forCity city : String,completion: @escaping (Weather?) -> Void){
        let weatherDb = getWeatherFromDb(forCity: city)
        
        if weatherDb != nil  && ( Calendar.current.dateComponents([.minute], from: Date(), to: weatherDb!.lastSync).minute! > 5 ) {
            completion(weatherDb!)
        }else{
            self.getWeatherFromApi(forCity: city, completion: completion)
        }
    }
    
    func getWeatherFromDb(forCity city:String) -> Weather?{
        return  Db.get(predicate: "city = '\(city)'")
    }
    
    func  getWeatherFromApi(forCity city : String,completion: @escaping (Weather?) -> Void){
        let params : [String:String] = [ "q": city, "appid":API_KEY]
        
        let wether =  Weather()
        wether.city = city
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        
        Alamofire.request(Base_URL, method: .get, parameters: params).responseJSON { response in
            if response.result.isSuccess {
                let json = JSON(response.result.value!)
                
                for (_,subJson):(String, JSON) in json["list"] {
                    let temp = self.convertToCelsius(subJson["main"]["temp"].doubleValue)
                    let temp_min = self.convertToCelsius(subJson["main"]["temp_min"].doubleValue)
                    let temp_max = self.convertToCelsius(subJson["main"]["temp_max"].doubleValue)
                    let date = Date(timeIntervalSince1970: TimeInterval(subJson["dt"].intValue))
                    let icon = subJson["weather"][0]["icon"].stringValue
                    let f = Forecast()
                    f.temperature = temp
                    f.temperatureMin = temp_min
                    f.temperatureMax = temp_max
                    f.date = date
                    f.icon = self.setIcon(forId: icon)
                    wether.forecasts.append(f)
                }
                self.saveWeather(weather: wether)
                completion(wether)
            }else{
                completion(self.getWeatherFromDb(forCity: city))
            }
        }
    }
    
    func groupByDay(from weather : Weather) -> Array<Forecast>{
        var dictDays = Array<Forecast>()
        let days =    Dictionary(grouping: weather.forecasts, by: { $0.date.day })
            .sorted(by: { $0.key  < $1.key })
        
        days.forEach { (arg: (key: Int, value: [Forecast])) in
            dictDays.append(arg.value[0])
        }
        
        return dictDays
    }
    
    func convertToCelsius(_ value : Double) -> Int {
        return Int(value -  273.15)
    }
    
    func setIcon(forId:String) -> String{
        switch forId {
        case "01d":
            return "snow.png"
        case "01n":
            return "snow.png"
        case "02d":
            return "partly_cloudy.png"
        case "02n":
            return "partly_cloudy.png"
        case "03d":
            return "cloudy.png"
        case "03n":
            return "cloudy.png"
        case "04d":
            return "cloudy.png"
        case "04n":
            return "cloudy.png"
        case "09d":
            return "light_rain.png"
        case "09n":
            return "light_rain.png"
        case "10d":
            return "light_rain.png"
        case "10n":
            return "light_rain.png"
        case "11d":
            return "thunder.png"
        case "11n":
            return "thunder.png"
        case "13d":
            return "snow.png"
        case "13n":
            return "snow.png"
        case "50d":
            return "foggy.png"
        case "50n":
            return "foggy.png"
        default:
            return "windy.png"
        }
    }
}
