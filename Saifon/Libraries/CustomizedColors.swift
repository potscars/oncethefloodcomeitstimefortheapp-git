//
//  CustomizedColors.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 28/09/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import SpriteKit

class CustomizedColors: NSObject {
    
    static func animateViewBackgroundColor(fromView view: UIView, fromColor: SKColor, toColor: SKColor, withDuration: Double) {
        
        view.backgroundColor = fromColor
        
        UIView.animate(withDuration: withDuration, delay: 0, options: [UIViewAnimationOptions.curveEaseOut, UIViewAnimationOptions.autoreverse, UIViewAnimationOptions.repeat], animations: {
            
            view.backgroundColor = toColor
            
        }, completion: nil)
        
    }
    
    static func animateTextColor(fromLabel label: UILabel, fromColor: SKColor, toColor: SKColor, withDuration: Double) {
        
        label.textColor = fromColor
        
        UIView.animate(withDuration: withDuration, delay: withDuration, options: [UIViewAnimationOptions.curveEaseOut, UIViewAnimationOptions.autoreverse, UIViewAnimationOptions.repeat], animations: {
            
            label.textColor = toColor
            
            }, completion: nil)
        
    }

}
