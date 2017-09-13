//
//  Alert.swift
//  Saifon
//
//  Created by Hainizam on 09/03/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import Foundation
import UIKit

class Alert{
    
    func showAlert(_ viewController: UIViewController, title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alert.addAction(action)
        
        DispatchQueue.main.async {
            
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
