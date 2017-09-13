//
//  RLCListDisplayTVC.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 07/10/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class RLCListDisplayTVC: UITableViewCell {
    
    
    @IBOutlet weak var uivRLCLDTVCBgView: UIView!
    @IBOutlet weak var uiivRLCLDTVCIndicator: UIImageView!
    @IBOutlet weak var uilRLCDTVCRiverName: UILabel!
    @IBOutlet weak var uilRLCLDTVCDate: UILabel!
    @IBOutlet weak var uilRLCDTVCCurrLevel: UILabel!
    @IBOutlet weak var uilRLCDTVCDiffLevel: UILabel!
    @IBOutlet weak var uilRLCDTVCPrevLevel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func UpdateCell(_ data: NSDictionary) {
        
        //sebelum ini:
        
        //uivRLCLDTVCBgView.backgroundColor = ColorInHex.colorWithHexString(data.valueForKey("RIVER_STATUS")?.objectAtIndex(1) as! String)
        //uilRLCDTVCRiverName.textColor = ColorInHex.colorWithHexString(data.valueForKey("RIVER_STATUS")?.objectAtIndex(2) as! String)
        
        uiivRLCLDTVCIndicator.image = WaterLevelLibrary.detectIndicatorIcon((data.value(forKey: "RIVER_STATUS") as AnyObject).objectAt(0) as! String)
        uivRLCLDTVCBgView.backgroundColor = WaterLevelLibrary.waterLevelBackgroundColor(levelStatus: (data.value(forKey: "RIVER_STATUS") as AnyObject).objectAt(0) as! String).object(at: 0) as? UIColor
        
        uilRLCDTVCRiverName.text = data.value(forKey: "RIVER_NAME") as? String
        //uilRLCDTVCRiverName.textColor = ColorInHex.colorWithHexString(data.valueForKey("RIVER_STATUS")?.objectAtIndex(2) as! String)
        uilRLCDTVCRiverName.textColor = WaterLevelLibrary.waterLevelBackgroundColor(levelStatus: (data.value(forKey: "RIVER_STATUS") as AnyObject).objectAt(0) as! String).object(at: 1) as? UIColor
        
        uilRLCLDTVCDate.text = data.value(forKey: "RIVER_REPORT_DATE") as? String
        //uilRLCLDTVCDate.textColor = ColorInHex.colorWithHexString(data.valueForKey("RIVER_STATUS")?.objectAtIndex(2) as! String)
        uilRLCLDTVCDate.textColor = WaterLevelLibrary.waterLevelBackgroundColor(levelStatus: (data.value(forKey: "RIVER_STATUS") as AnyObject).objectAt(0) as! String).object(at: 1) as? UIColor
        
        uilRLCDTVCCurrLevel.text = data.value(forKey: "RIVER_CURRENT_LEVEL") as? String
        uilRLCDTVCCurrLevel.textColor = ColorInHex.colorWithHexString((data.value(forKey: "RIVER_STATUS") as AnyObject).objectAt(2) as! String)
        uilRLCDTVCCurrLevel.textColor = WaterLevelLibrary.waterLevelBackgroundColor(levelStatus: (data.value(forKey: "RIVER_STATUS") as AnyObject).objectAt(0) as! String).object(at: 1) as? UIColor
        
        uilRLCDTVCDiffLevel.text = data.value(forKey: "RIVER_DIFFERENCE") as? String
        //uilRLCDTVCDiffLevel.textColor = ColorInHex.colorWithHexString(data.valueForKey("RIVER_STATUS")?.objectAtIndex(2) as! String)
        uilRLCDTVCDiffLevel.textColor = WaterLevelLibrary.waterLevelBackgroundColor(levelStatus: (data.value(forKey: "RIVER_STATUS") as AnyObject).objectAt(0) as! String).object(at: 1) as? UIColor
        
        uilRLCDTVCPrevLevel.text = data.value(forKey: "RIVER_PREVIOUS_LEVEL") as? String
        //uilRLCDTVCPrevLevel.textColor = ColorInHex.colorWithHexString(data.valueForKey("RIVER_STATUS")?.objectAtIndex(2) as! String)
         uilRLCDTVCPrevLevel.textColor = WaterLevelLibrary.waterLevelBackgroundColor(levelStatus: (data.value(forKey: "RIVER_STATUS") as AnyObject).objectAt(0) as! String).object(at: 1) as? UIColor
        
        
    }

    override func setSelected(_ _selected: Bool, animated: Bool) {
        super.setSelected(isSelected, animated: animated)

        // Configure the view for the selected state
    }

}
