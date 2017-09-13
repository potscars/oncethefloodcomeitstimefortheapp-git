//
//  SaifonVCCell.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 01/06/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SaifonVCCell: UITableViewCell {

    @IBOutlet weak var uilSVCCRiverName: UILabel!
    @IBOutlet weak var uilSVCCReportDate: UILabel!
    @IBOutlet weak var uilSVCCRiverLevelDifference: UILabel!
    @IBOutlet weak var uilSVCCRiverCurrentLevel: UILabel!
    @IBOutlet weak var uilSVCCRiverLevelPrevious: UILabel!
    @IBOutlet weak var uiivSVCCRiverImage: UIImageView!
    @IBOutlet weak var uivSVCCInfoBack: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func UpdateCell(_ data:NSDictionary)
    {
        
        uilSVCCRiverName.text = data.value(forKey: "RIVER_NAME") as? String
        uilSVCCReportDate.text = data.value(forKey: "RIVER_REPORT_DATE") as? String
        uilSVCCRiverCurrentLevel.text = "\((data.value(forKey: "RIVER_CURR_LEVEL") as? String)!)m"
        uilSVCCRiverLevelPrevious.text = "30 minit sebelum: \(WaterLevelLibrary().calculate30minsDifference((data.value(forKey: "RIVER_CURR_LEVEL") as? String)!,(data.value(forKey: "RIVER_LEVEL_DIFFERENCE") as? String)!))m"
        uilSVCCRiverLevelDifference.text = "(\((data.value(forKey: "RIVER_LEVEL_DIFFERENCE") as? String)!)m)"
        
        if let diff = data.value(forKey: "RIVER_DIFFERENCE_DIRECTION") as? String {
            WaterLevelLibrary().changeIconToUporDown(diff,targetImage: uiivSVCCRiverImage)
        }
        else {
            WaterLevelLibrary().changeIconToUporDown(nil,targetImage: uiivSVCCRiverImage)
        }
        
        if(data.value(forKey: "RIVER_LEVEL_PHASE") as! Int == 3)
        {
            uivSVCCInfoBack.backgroundColor = ColorInHex.colorWithHexString("#F44336")
            uilSVCCRiverName.textColor = ColorInHex.colorWithHexString("#ffffff")
            uilSVCCReportDate.textColor = ColorInHex.colorWithHexString("#ffffff")
            uilSVCCRiverCurrentLevel.textColor = ColorInHex.colorWithHexString("#ffffff")
            uilSVCCRiverLevelPrevious.textColor = ColorInHex.colorWithHexString("#ffffff")
            uilSVCCRiverLevelDifference.textColor = ColorInHex.colorWithHexString("#ffffff")
        }
        else if(data.value(forKey: "RIVER_LEVEL_PHASE") as! Int == 2)
        {
            uivSVCCInfoBack.backgroundColor = ColorInHex.colorWithHexString("#FFEB3B")
            uilSVCCRiverName.textColor = ColorInHex.colorWithHexString("#000000")
            uilSVCCReportDate.textColor = ColorInHex.colorWithHexString("#000000")
            uilSVCCRiverCurrentLevel.textColor = ColorInHex.colorWithHexString("#000000")
            uilSVCCRiverLevelPrevious.textColor = ColorInHex.colorWithHexString("#000000")
            uilSVCCRiverLevelDifference.textColor = ColorInHex.colorWithHexString("#000000")
        }
        else
        {
            uivSVCCInfoBack.backgroundColor = ColorInHex.colorWithHexString("#4CAF50")
            uilSVCCRiverName.textColor = ColorInHex.colorWithHexString("#ffffff")
            uilSVCCReportDate.textColor = ColorInHex.colorWithHexString("#ffffff")
            uilSVCCRiverCurrentLevel.textColor = ColorInHex.colorWithHexString("#ffffff")
            uilSVCCRiverLevelPrevious.textColor = ColorInHex.colorWithHexString("#ffffff")
            uilSVCCRiverLevelDifference.textColor = ColorInHex.colorWithHexString("#ffffff")
        }

    }
    
}
