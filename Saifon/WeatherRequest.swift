//
//  WeatherRequest.swift
//  Saifon
//
//  Created by Hainizam on 03/03/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import Foundation

class WeatherRequest {
    
    var viewController: UIViewController!
    
    func weatherRequest(_ viewController: UIViewController?, completion: @escaping ([Weather]) -> ()) {
        
        self.viewController = viewController
        var weatherList = [Weather]()
        
        let url = URL.init(string: URLs.kSAIFON_LATEST_SENSOR())!
        
        let requestData = NSMutableURLRequest.init(url: url, cachePolicy:NSURLRequest.CachePolicy.useProtocolCachePolicy , timeoutInterval: 60.0)
        requestData.httpMethod = "GET"
        requestData.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared

        let task: URLSessionDataTask = session.dataTask(with: requestData as URLRequest, completionHandler: { (data, response, error) in
            
            guard error == nil else {
                Alert().showAlert(self.viewController, title: "Amaran!", message: "Ralat tidak dapat berhubung dengan server..")
                print("Error")
                return
            }
            
            guard let responseData = data else {
                print("No data in return")
                return
            }
            
            weatherList = self.fetchJSONData(responseData, response: response)!
            
            completion(weatherList)
        }) 
        
        task.resume()
    }
    
    fileprivate func fetchJSONData(_ data: Data, response: URLResponse?) -> [Weather]?{
        
        do {
            
            let res = response as! HTTPURLResponse
            let resCode = res.statusCode
            
            if resCode >= 200 && resCode <= 300 {
                
                let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
                
                let status = jsonData.value(forKey: "status") as! Int
                
                print(status)
                
                if status == 1 {
                    
                    let weatherData = jsonData.value(forKey: "data") as! NSArray
                    
                    var weatherList = [Weather]()
                    var sensorId: String?
                    var description: String?
                    var unit: String?
                    var order: Int?
                    var value: String?
                    
                    for result in weatherData
                    {
                        
                        if let sensor_id = (result as AnyObject).value(forKey: "sensor_id") as? String {
                            sensorId = sensor_id
                        }
                        
                        if let descriptionResult = (result as AnyObject).value(forKey: "description") as? String {
                            description = descriptionResult
                        }
                        
                        if let unitResult = (result as AnyObject).value(forKey: "unit") as? String {
                            unit = unitResult
                        }
                        
                        if let orderResult = (result as AnyObject).value(forKey: "order") as? String {
                            order = Int(orderResult)
                        }
                        
                        if let lastest_data = (result as AnyObject).value(forKey: "first_last_data") as? NSDictionary, let valueResult = lastest_data.value(forKey: "value") as? String {
                            value = valueResult
                        }
                        
                        weatherList.append(Weather(sensorId: sensorId, description: description, unit: unit, order: order, value: value))
                    }
                    
                    return weatherList
                    
                } else {
                    //Failed
                    return nil
                }
                
            } else {
                
                //Out of range
            }
            
        } catch let error{
            
            print("Catch error: \(error)")
        }
        
        return nil
    }
}

class Weather {
    
    var sensorId: String?
    var description: String?
    var unit: String?
    var order: Int?
    var value: String?
    
    required init(sensorId: String?, description: String?, unit: String?, order: Int?, value: String?) {
        
        self.sensorId = sensorId
        self.description = description
        self.unit = unit
        self.order = order
        self.value = value
    }
}




























