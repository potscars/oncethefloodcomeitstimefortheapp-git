//
//  CollectionViewCell.swift
//  Saifon
//
//  Created by Hainizam on 03/03/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var weather: Weather! {
        didSet {
            
            self.updateCell()
        }
    }
    
    func updateCell() {
        
        let font = UIFont(name: ".SFUIText-Light", size: 14.0)!
        
        descriptionLabel.text = weather.description!
        descriptionLabel.font = font
        valueLabel.text = "\(weather.value!) \(weather.unit!)"
        valueLabel.font = font
        
        var featuredImage: UIImage = UIImage()
        
        if weather.sensorId == "PRES" {
            
            let valueString = weather.value!
            
            if let intValue = Float(valueString) {
                let kPaValue =  intValue / 1000
                
                let formattedValue = String(format: "%.2f", kPaValue)
                
                valueLabel.text = "\(formattedValue) \(weather.unit!)"
            }

            featuredImage = UIImage(named: "pressure.png")!
        } else if weather.sensorId == "PM2_5" || weather.sensorId == "PM10" {
            
            featuredImage = UIImage(named: "pm10.png")!
        } else if weather.sensorId == "LUX" {
            
            featuredImage = UIImage(named: "luminousity.png")!
        } else if weather.sensorId == "PLV1" {
            
            featuredImage = UIImage(named: "rain_gauge.png")!
        } else if weather.sensorId == "CO" {
            
            featuredImage = UIImage(named: "carbonmonoxide.png")!
        }
        
        featuredImageView.contentMode = .scaleAspectFit
        featuredImageView.image = featuredImage
    }
}















