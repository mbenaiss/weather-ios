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
    
    let realm = try! Realm()
    
    
    func saveWeather(weather : Weather){
        try! realm.write {
            realm.add(weather,update: true )
        }
    }
    
    
    func  getWeather(forCity city : String,completion: @escaping (Weather) -> Void){
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        let weatherDb = getWeatherFromDb(forCity: city)
        
        if weatherDb != nil  && ( Calendar.current.dateComponents([.minute], from: Date(), to: weatherDb!.lastSync).minute! > 5 ) {
            completion(weatherDb!)
        }else{
            self.getWeatherFromApi(forCity: city, completion: completion)
        }
    }
    
    func getWeatherFromDb(forCity city:String) -> Weather?{
        return  Array(realm.objects(Weather.self).filter("city = '\(city)'")).first
    }
    
    func  getWeatherFromApi(forCity city : String,completion: @escaping (Weather) -> Void){
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
                    f.icon = icon
                    wether.forecasts.append(f)
                }
                self.saveWeather(weather: wether)
                completion(wether)
            }else{
                print("\(response.result.error!)")
                completion(wether)
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
    
}
