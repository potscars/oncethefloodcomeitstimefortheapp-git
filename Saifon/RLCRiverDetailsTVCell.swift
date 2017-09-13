//
//  RLCRiverDetailsTVCell.swift
//  Saifon
//
//  Cell-id: RiverDetailedTwoCellID
//
//  Created by Mohd Zulhilmi Mohd Zain on 11/01/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class RLCRiverDetailsTVCell: UITableViewCell {
    
    @IBOutlet weak var uilRLCRDTVCRiverName: UILabel!
    @IBOutlet weak var uilRLCRDTVCRiverDate: UILabel!
    @IBOutlet weak var uilRLCRDTVCRiverCurrLevel: UILabel!
    @IBOutlet weak var uilRLCRDTVCRiverDiff: UILabel!
    @IBOutlet weak var uilRLCRDTVCRiverPrev: UILabel!
    @IBOutlet weak var uivRLCRDTVCDanger: UIView!
    @IBOutlet weak var uilRLCRDTVCWarning: UIView!
    @IBOutlet weak var uilRLCRDTVCCaution: UIView!
    @IBOutlet weak var uilRLCRDTVCSafe: UIView!
    @IBOutlet weak var riverDetailsBackgroundView: UIView!
    @IBOutlet weak var riverDetailsIndicatorView: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell(_ data: NSDictionary)
    {
        let riverStatus = (data.value(forKey: "RIVER_STATUS") as AnyObject).object(at: 0) as! String
        
        if riverStatus == "RIVER_IN_DANGER_MODE" {
            
            riverDetailsBackgroundView.backgroundColor = UIColor.red
            riverDetailsBackgroundView.layer.borderColor = UIColor.black.cgColor
            riverDetailsBackgroundView.layer.borderWidth = 2
        } else {
            
            riverDetailsBackgroundView.backgroundColor = UIColor.white
            riverDetailsBackgroundView.layer.borderColor = .none
            riverDetailsBackgroundView.layer.borderWidth = 0
        }
        
        uilRLCRDTVCRiverName.text = data.value(forKey: "RIVER_NAME") as? String
        uilRLCRDTVCRiverName.textColor = WaterLevelLibrary.waterLevelBackgroundColor(levelStatus: riverStatus).object(at: 1) as? UIColor
        uilRLCRDTVCRiverDate.text = data.value(forKey: "RIVER_REPORT_DATE") as? String
        uilRLCRDTVCRiverDate.textColor = WaterLevelLibrary.waterLevelBackgroundColor(levelStatus: riverStatus).object(at: 1) as? UIColor
        uilRLCRDTVCRiverCurrLevel.text = data.value(forKey: "RIVER_CURRENT_LEVEL") as? String
        uilRLCRDTVCRiverCurrLevel.textColor = WaterLevelLibrary.waterLevelBackgroundColor(levelStatus: riverStatus).object(at: 1) as? UIColor
        uilRLCRDTVCRiverDiff.text = data.value(forKey: "RIVER_DIFFERENCE") as? String
        uilRLCRDTVCRiverDiff.textColor = WaterLevelLibrary.waterLevelBackgroundColor(levelStatus: riverStatus).object(at: 1) as? UIColor
        uilRLCRDTVCRiverPrev.text = "30 minit sebelum: \((data.value(forKey: "RIVER_PREVIOUS_LEVEL") as? String ?? "")!)"
        uilRLCRDTVCRiverPrev.textColor = WaterLevelLibrary.waterLevelBackgroundColor(levelStatus: riverStatus).object(at: 1) as? UIColor
        
        indicatorSet(WaterLevelLibrary.detectIndicatorNumber(riverStatus))
    }
    
    func indicatorSet(_ indicatorNumber: Int)
    {
        uilRLCRDTVCSafe.layer.borderColor = UIColor.black.cgColor
        uilRLCRDTVCSafe.layer.borderWidth = 1
        uilRLCRDTVCSafe.clipsToBounds = true
        uilRLCRDTVCCaution.layer.borderColor = UIColor.black.cgColor
        uilRLCRDTVCCaution.layer.borderWidth = 1
        uilRLCRDTVCCaution.clipsToBounds = true
        uilRLCRDTVCWarning.layer.borderColor = UIColor.black.cgColor
        uilRLCRDTVCWarning.layer.borderWidth = 1
        uilRLCRDTVCWarning.clipsToBounds = true
        uivRLCRDTVCDanger.layer.borderColor = UIColor.black.cgColor
        uivRLCRDTVCDanger.layer.borderWidth = 1
        uivRLCRDTVCDanger.clipsToBounds = true
        
        if(indicatorNumber == 0)
        {
            uilRLCRDTVCSafe.layer.backgroundColor = UIColor.init(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0).cgColor
            uilRLCRDTVCCaution.layer.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
            uilRLCRDTVCWarning.layer.backgroundColor = UIColor.init(red: 1.0, green: 1.8, blue: 1.0, alpha: 1.0).cgColor
            uivRLCRDTVCDanger.layer.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        }
        else if(indicatorNumber == 1)
        {
            uilRLCRDTVCSafe.layer.backgroundColor = UIColor.init(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0).cgColor
            uilRLCRDTVCCaution.layer.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0).cgColor
            uilRLCRDTVCWarning.layer.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
            uivRLCRDTVCDanger.layer.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        }
        else if(indicatorNumber == 2)
        {
            uilRLCRDTVCSafe.layer.backgroundColor = UIColor.init(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0).cgColor
            uilRLCRDTVCCaution.layer.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0).cgColor
            uilRLCRDTVCWarning.layer.backgroundColor = UIColor.init(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0).cgColor
            uivRLCRDTVCDanger.layer.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        }
        else if(indicatorNumber == 3)
        {
            uilRLCRDTVCSafe.layer.backgroundColor = UIColor.init(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0).cgColor
            uilRLCRDTVCCaution.layer.backgroundColor = UIColor.init(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0).cgColor
            uilRLCRDTVCWarning.layer.backgroundColor = UIColor.init(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0).cgColor
            uivRLCRDTVCDanger.layer.backgroundColor = UIColor.init(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0).cgColor
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
