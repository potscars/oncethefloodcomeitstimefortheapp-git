//
//  RLCListDetailsDisplayTVC.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 11/10/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class RLCListDetailsDisplayTVC: UITableViewCell {
    
    @IBOutlet weak var uiivRLCLDDTVCIndicatorIcon: UIImageView!
    @IBOutlet weak var uilRLCDDTVCRiverName: UILabel!
    @IBOutlet weak var uilRLCDDTVCDateReport: UILabel!
    @IBOutlet weak var uilRLCDDTVCCurrLevel: UILabel!
    @IBOutlet weak var uilRLCDDTVCDiffLevel: UILabel!
    @IBOutlet weak var uilRLCDDTVCPrevLevel: UILabel!
    @IBOutlet weak var uivRLCLDDTVCInfoBack: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ _selected: Bool, animated: Bool) {
        super.setSelected(isSelected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func UpdateCell(_ data: NSDictionary) {
        
        uiivRLCLDDTVCIndicatorIcon.image = WaterLevelLibrary.detectIndicatorIcon((data.value(forKey: "RIVER_STATUS") as AnyObject).objectAt(0) as! String)
        uilRLCDDTVCRiverName.text = data.value(forKey: "RIVER_NAME") as? String
        uilRLCDDTVCDateReport.text = data.value(forKey: "RIVER_REPORT_DATE") as? String
        uilRLCDDTVCCurrLevel.text = data.value(forKey: "RIVER_CURRENT_LEVEL") as? String
        uilRLCDDTVCDiffLevel.text = data.value(forKey: "RIVER_DIFFERENCE") as? String
        uilRLCDDTVCPrevLevel.text = data.value(forKey: "RIVER_PREVIOUS_LEVEL") as? String
    }
    
    
}
