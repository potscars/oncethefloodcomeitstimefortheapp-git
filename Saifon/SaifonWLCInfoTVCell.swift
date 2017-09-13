//
//  SaifonWLCInfoTVCell.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 16/06/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SaifonWLCInfoTVCell: UITableViewCell {

    @IBOutlet weak var uivSWLCITVCBackground: UIView!
    @IBOutlet weak var uilSWLCITVCRiverName: UILabel!
    @IBOutlet weak var uilSWLCITVCRiverCurrentLevel: UILabel!
    @IBOutlet weak var uilSWLCITVCDateReport: UILabel!
    @IBOutlet weak var uilSWLCITVCWarningLevel: UILabel!
    @IBOutlet weak var uilSWLCITVCLogoIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func UpdateCell(_ data: NSDictionary)
    {
        //uivSWLCITVCBackground.backgroundColor =
        uilSWLCITVCRiverName.text = data.value(forKey: "RIVER_NAME") as? String
        uilSWLCITVCRiverCurrentLevel.text = data.value(forKey: "RIVER_CURR_LEVEL") as? String
        uilSWLCITVCDateReport.text = data.value(forKey: "RIVER_REPORT_DATE") as? String
        uilSWLCITVCWarningLevel.text = data.value(forKey: "RIVER_MAX_LEVEL") as? String
        
        if(data.value(forKey: "RIVER_STATUS") as? String == "BAHAYA")
        {
            uivSWLCITVCBackground.backgroundColor = ColorInHex.colorWithHexString("#F44336")
        }
        else if(data.value(forKey: "RIVER_STATUS") as? String == "AMARAN")
        {
            uivSWLCITVCBackground.backgroundColor = ColorInHex.colorWithHexString("#FFEB3B")
        }
        else
        {
            uivSWLCITVCBackground.backgroundColor = ColorInHex.colorWithHexString("#4CAF50")
        }
    }

}
