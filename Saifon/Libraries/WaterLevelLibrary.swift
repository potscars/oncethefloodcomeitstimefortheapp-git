//
//  WaterLevelLibrary.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 27/09/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class WaterLevelLibrary: NSObject {

    func changeIconToUporDown(_ intervalType: String?, targetImage: UIImageView) {
        
        //print("[WaterLevelLibrary] Type return is \(intervalType!)")
        
        if(intervalType != nil) {
            
            switch (intervalType!) {
            case "up":
                targetImage.image = UIImage(named: "ic_arrow_menaik.png")
                break
            case "down":
                targetImage.image = UIImage(named: "ic_arrow_menurun.png")
                break
            default:
                targetImage.image = UIImage(named: "ic_arrow_tiada.png")
                break
            }
            
        }
        else {
            targetImage.image = UIImage(named: "ic_arrow_tiada.png")
        }
        
    }
    
    func calculate30minsDifference(_ currentWater: String, _ intervalDifference: String) -> String
    {
        
        let buangBendaAsing: String = intervalDifference.replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
        
        print("[SaifonVCCell] Current water is \(currentWater) and Difference is \(buangBendaAsing)")
        
        let intervalDifference: Double = Double(buangBendaAsing)!
        print("[SaifonVCCell] Converted intervalDifference is \(intervalDifference)")
        let currentWaterDeep: Double = Double(currentWater)!
        print("[SaifonVCCell] Converted waterDeep \(currentWaterDeep)")
        
        var totalOfDifference: Double = 0.00
        
        if(intervalDifference != Double(0.00)){
            print("[SaifonVCCell] Difference is in negative")
            totalOfDifference = currentWaterDeep - intervalDifference
            print("[SaifonVCCell] Total is \(totalOfDifference)")
        }
        else {
            print("[SaifonVCCell] Difference is in positive")
            totalOfDifference = currentWaterDeep + intervalDifference
            print("[SaifonVCCell] Total is \(totalOfDifference)")
        }
        
        
        
        return String(totalOfDifference)
    }
    
    static func detectIndicatorIcon(_ status: String) -> UIImage {
        
        if(status == "RIVER_IN_SAFE_MODE") {
            return UIImage.init(named: "ic_wlevel_safe.png")!
        }
        else if(status == "RIVER_IN_CAUTION_MODE") {
            return UIImage.init(named: "ic_wlevel_caution.png")!
        }
        else if(status == "RIVER_IN_WARNING_MODE") {
            return UIImage.init(named: "ic_wlevel_warning.png")!
        }
        else if(status == "RIVER_IN_DANGER_MODE") {
            return UIImage.init(named: "ic_wlevel_danger.png")!
        }
        else {
            return UIImage.init(named: "ic_wlevel_danger.png")!
        }
        
    }
    
    static func detectIndicatorNumber(_ status: String) -> Int {
        
        if(status == "RIVER_IN_SAFE_MODE") {
            return 0
        }
        else if(status == "RIVER_IN_CAUTION_MODE") {
            return 1
        }
        else if(status == "RIVER_IN_WARNING_MODE") {
            return 2
        }
        else if(status == "RIVER_IN_DANGER_MODE") {
            return 3
        }
        else {
            return 3
        }
        
    }
    
    
    static func waterLevelStatus(currentLevel currLevelStr: String, caution cautionStr: String, warning warningStr: String, danger dangerStr: String) -> NSArray {
        
        //return [RIVER STATUS,BACKGROUNDCOLORINHEX,TEXTCOLORINHEX]
        
        let currInt: Double = Double(currLevelStr)!
        let cautionInt: Double = Double(cautionStr)!
        let warningInt: Double = Double(warningStr)!
        let dangerInt: Double = Double(dangerStr)!
    
        print("[WaterLevelLibrary] Current Level: \(currInt), Caution Level: \(cautionInt), Warning Level: \(warningInt), Danger Level: \(dangerInt)")
        
        if(currInt > dangerInt)
        {
            print("[WaterLevelLibrary] Current: \(currInt), Danger: \(dangerInt), is Danger Mode")
            return ["RIVER_IN_DANGER_MODE","F44336","FFFFFF"]
        }
        else if(currInt > warningInt)
        {
            print("[WaterLevelLibrary] Current: \(currInt), Warning: \(warningInt), is Warning Mode")
            return ["RIVER_IN_WARNING_MODE","FF943B","FFFFFF"]
        }
        else if(currInt > cautionInt)
        {
            print("[WaterLevelLibrary] Current: \(currInt), Caution: \(cautionInt), is Caution Mode")
            return ["RIVER_IN_CAUTION_MODE","FFEB3B","FFFFFF"]
        }
        else
        {
            return ["RIVER_IN_SAFE_MODE","4CAF50","FFFFFF"]
        }
        
    }
    
    static func waterLevelBackgroundColor(levelStatus stat:String) -> NSArray
    {
        if(stat == "RIVER_IN_DANGER_MODE")
        {
            return [UIColor.red,UIColor.white]
        }
        else
        {
            return [UIColor.white,UIColor.black]
        }
    }
    
    static func graphFrameByPhoneSize(_ view: UIView)
    {
        if(UIScreen.main.responds(to: #selector(NSDecimalNumberBehaviors.scale)) && UIScreen.main.scale == 2.0) {
            // Retina display
            print("[WaterLevelLibrary] Device is retina display")
            
        } else {
            // non-Retina display
            print("[WaterLevelLibrary] Device is not retina display")
        }
        
    }
    
}
