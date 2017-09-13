//
//  WebServices.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 23/06/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import MBProgressHUD

class WebServices {
    
    static func GetFeedWaterLevelData(isRefresh: Bool) -> NSDictionary {
        
        print("[WebServices] Getting Water Level Data Feed")
        
        let getLoginURL = URL.init(string: URLs.kSAIFON_LANDING_PAGE_URL())
        
        print("[WebServices] Requesting FeedWaterLevelData...")
        
        let requestData = NSMutableURLRequest.init(url: getLoginURL!, cachePolicy:NSURLRequest.CachePolicy.useProtocolCachePolicy , timeoutInterval: 60.0)
        requestData.httpMethod = "GET"
        requestData.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        print("[WebServices] Initiating session...")
        
        var loginDataFromJSON = NSDictionary()
        let loginSession = URLSession.shared
        let loginSessionDataTask: URLSessionDataTask = loginSession.dataTask(with: requestData as URLRequest) { (retrievedData,response ,error) -> Void in
            do {
                
                print("[WebServices] Retrieving response....")
                
                loginDataFromJSON = try JSONSerialization.jsonObject(with: retrievedData!, options: []) as! NSDictionary
                
                print("[WebServices] Feed Data Response in raw format is", loginDataFromJSON)
                
            }
            catch let error as NSError
            {
                print("[WebServices] Error while retrieve login data ",error)
                
                //let dataFailed: NSDictionary = ["reason":"ERROR_FROM_API"]
                loginDataFromJSON = ["status":"failed","description":"ERROR_FROM_API"]
            
            }
        }
        
        loginSessionDataTask.resume()
        
        return loginDataFromJSON
    }
    
    static func GetOverallWaterLevelData(dataAmount amount: String) -> NSMutableArray
    {
        //let semaphore = dispatch_semaphore_create(0)
        //let dispatchSerial = dispatch_queue_create("dispatchSerial", DISPATCH_QUEUE_SERIAL)
        var overallRiverData: NSMutableArray = []
        
        print("[WebServices] Getting Overall Water Level Data Feed")
        
        let getLoginURL = URL.init(string: URLs.kSAIFON_WATER_LEVEL_DATA_URL(amount))
        
        print("[WebServices] Requesting GetOverallWaterLevelData...")
        
        let requestData = NSMutableURLRequest.init(url: getLoginURL!, cachePolicy:NSURLRequest.CachePolicy.useProtocolCachePolicy , timeoutInterval: 60.0)
        requestData.httpMethod = "GET"
        requestData.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        print("[WebServices] Initiating GetOverallWaterLevelData...")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: requestData as URLRequest) { (data, response, error) in
            
            if let retrievedData = data {
                
                do {
                    
                    if let getDataFromJSON = try JSONSerialization.jsonObject(with: retrievedData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSMutableArray {
                        
                        DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async {
                            
                            overallRiverData = getDataFromJSON
                            
                        }
                    }
                    //print("[WebServices] Check data: ",getDataFromJSON)
                    //dispatch_semaphore_signal(semaphore)
                }
                catch let error as NSError {
                    
                    print("[WebServices] Error while retrieve login data ",error)
                }
            }
            else if let error = error {
                print("[WebServices] Error while retrieve login data ",error)
            }
        }
        
        task.resume()
        //dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        
        return overallRiverData
    }
}










