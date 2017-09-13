//
//  Libraries.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 23/08/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import MBProgressHUD

class Libraries {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    func CheckInternetConnection(_ viewController: AnyObject) -> Bool {
        
        if(appDelegate.isConnectedToNetwork() == false)
        {
            print("[Libraries] No internet connection.")
            
            let alert = UIAlertController(title: "Masalah", message: "Sambungan Internet gagal. Sila periksa sambungan Internet anda.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action: UIAlertAction) -> Void in
                
            }))
            
            viewController.parent!!.present(alert, animated: true, completion: nil)
            
            return false
        }
        else
        {
            print("[Libraries] Has internet connection.")
            return true
        }
        
    }
    
    static func isStringNumerical(_ string : String) -> Bool {
        // Only allow numbers. Look for anything not a number.
        let range = string.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted)
        return (range == nil)
    }
    
    static func checkIfStringOrInt(_ value: AnyObject) -> AnyObject
    {
        if value is String {
            return value as! String as AnyObject
        }
        else {
            return value as! Int as AnyObject
        }
    }
    
    static func dateFormatConverter(_ valueInStr: String) -> String
    {
        print("[Libraries] Value parsed is \(valueInStr)")
        
        let originalDate = DateFormatter()
        originalDate.timeZone = TimeZone.init(identifier: "GMT+08:00")
        originalDate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //var dateSeparator = NSDateComponents.
        let setDate: Date = originalDate.date(from: valueInStr)!
        originalDate.dateFormat = "dd MMMM yyyy, h:mm:ss a"
        let dateToParse = String(validatingUTF8: originalDate.string(from: setDate))!
        
        return dateToParse
    }
    
    static func waterDepthConverter(_ valueInStr:String) -> Double
    {
        return Double(NumberFormatter().number(from: valueInStr)!)
    }
    
    static func dateFormatConverterForChart(_ valueInStr:String) -> Double
    {
        // format from API is 2016-08-22 10:46:05
        
        let originalDate = DateFormatter()
        originalDate.dateFormat = "yyyy-MM-dd HH:mm:ss"
        //var dateSeparator = NSDateComponents.
        let setDate: Date = originalDate.date(from: valueInStr)!
        originalDate.dateFormat = "HH.mm"
        let dateToParse: Double = Double(originalDate.string(from: setDate))!
        
        print("[Libraries] Get Date: ",dateToParse)
        
        return dateToParse
    }
    
    static func waterLevelConvert(_ valueInStr:String) -> String
    {
        return "(\(valueInStr) m)"
    }
    
    static func displayProgress(viewController: UIViewController, MBProgressHUDDelegation:MBProgressHUDDelegate, animType:MBProgressHUDAnimation, labelText:String) -> MBProgressHUD {
        
        print("[Libraries] Showing Progress Bar...")
        
        print("[Libraries] Progressing bar stage 1")
        
        let progressHud: MBProgressHUD = MBProgressHUD.showAdded(to: viewController.view.window!, animated: true)
        
        print("[Libraries] Progressing bar stage 2")
        
        progressHud.animationType = animType
        
        print("[Libraries] Progressing bar stage 3")
        
        progressHud.label.text = labelText
        
        print("[Libraries] Progressing bar stage 4")
        
        progressHud.label.font = UIFont.init(name: "Arial", size: CGFloat(12))
        
        print("[Libraries] Progressing bar stage 5")
        
        progressHud.delegate = MBProgressHUDDelegation
        
        print("[Libraries] Progressing bar completed")
        
        return progressHud
    }
    

    
    /*
    static func compileDataForPosX(data: String, forRange: Int) -> [AnyObject] {
    
        var compiledData = []
        
        for var i in 0...forRange {
            
            compiledData = [""]
            
        }
        
        return compiledData
    }
    */
    
}
