//
//  HPDaripadaTVCell.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 13/07/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class HPDaripadaTVCell: UITableViewCell {

    @IBOutlet weak var uitfHPDTVCFrom: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func GetString() -> String {
        
        return uitfHPDTVCFrom.text!
    }

}
