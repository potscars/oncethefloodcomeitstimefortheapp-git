//
//  LoadingSpinner.swift
//  Saifon
//
//  Created by Hainizam on 08/03/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import Foundation
import UIKit

class LoadingSpinner {
    
    //MARK: - Variables for setting up loading spinner.
    let loadingView = UIView()
    let spinner = UIActivityIndicatorView()
    let loadingLabel = UILabel()
    
    let view: UIView!
    let isNavBar: Bool!
    
    init(view: UIView, isNavBar: Bool) {
        self.view = view
        self.isNavBar = isNavBar
    }
    
    func setLoadingScreen() {
        
        // Sets the view which contains the loading text and the spinner
        let width: CGFloat = 120
        let height: CGFloat = 50
        let x = (self.view.bounds.width / 2) - (width / 2)
        let y: CGFloat!
            
        if self.isNavBar == true {
           y = (self.view.bounds.height / 2) - (height / 2) - 40
        } else {
           y = (self.view.bounds.height / 2) - (height / 2)
        }
        
        loadingView.frame = CGRect(x: x, y: y, width: width, height: height)
        loadingView.backgroundColor = UIColor.black
        loadingView.layer.cornerRadius = 5
        loadingView.clipsToBounds = true
        
        let yItem = (height / 2) - (30 / 2)
        
        // Sets loading text
        self.loadingLabel.textColor = UIColor.white
        self.loadingLabel.textAlignment = NSTextAlignment.center
        self.loadingLabel.text = "Loading..."
        self.loadingLabel.frame = CGRect(x: 0, y: yItem, width: 140, height: 30)
        
        // Sets spinner
        self.spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.white
        self.spinner.frame = CGRect(x: 0, y: yItem, width: 30, height: 30)
        self.spinner.startAnimating()
        
        // Adds text and spinner to the view
        loadingView.addSubview(self.spinner)
        loadingView.addSubview(self.loadingLabel)
        
        self.view.addSubview(loadingView)
        
    }
    
    // Remove the activity indicator from the main view
    func removeLoadingScreen() {
        
        // Hides and stops the text and the spinner
        self.spinner.stopAnimating()
        self.loadingView.removeFromSuperview()
    }
}






