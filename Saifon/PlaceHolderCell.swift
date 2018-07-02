//
//  PlaceHolderCell.swift
//  dashboardKB
//
//  Created by Hainizam on 28/02/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class PlaceHolderCell: UITableViewCell {
    
    let riverNameLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sungai Pahang"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightMedium)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        
        return label
    }()
    
    let warningLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Coming soon!"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.3
        
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAutoLayout()
    }
    
    private func setupAutoLayout() {
        
        contentView.addSubview(riverNameLabel)
        contentView.addSubview(warningLabel)
        
        riverNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0).isActive = true
        riverNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0).isActive = true
        
        warningLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        warningLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        warningLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0).isActive = true
        warningLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16.0).isActive = true
        
    }
    
    func updateUI(withName name: String) {
        riverNameLabel.text = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

















