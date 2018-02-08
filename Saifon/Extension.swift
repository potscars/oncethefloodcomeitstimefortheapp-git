//
//  Extension.swift
//  Saifon
//
//  Created by Hainizam on 07/02/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension UIColor {
    
    static let darkBlue = UIColor.init(red: 21/255, green: 67/255, blue: 96/255, alpha: 1)
    static let lightBlue = UIColor.init(red: 93/255, green: 173/255, blue: 226/255, alpha: 1)
}

