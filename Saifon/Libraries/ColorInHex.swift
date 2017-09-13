//
//  ColorInHex.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 20/06/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class ColorInHex: UIColor {
    
    class func colorWithHexString(_ hex: String) -> UIColor
    {
        var rgbValue: UInt32 = 0
        let scanner = Scanner(string:hex as String)
        scanner.scanLocation = 1
        scanner.scanHexInt32(&rgbValue)
        return UIColor.init(red: CGFloat((Int(rgbValue) & 0xFF0000) >> 16)/255.0, green: CGFloat((Int(rgbValue) & 0x00FF00) >> 8)/255.0, blue: CGFloat(Int(rgbValue) & 0x0000FF)/255.0, alpha: 1.0)
    }
    
}
