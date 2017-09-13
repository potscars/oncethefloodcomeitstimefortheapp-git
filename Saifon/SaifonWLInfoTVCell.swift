//
//  SaifonWLInfoTVCell.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 09/06/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SaifonWLInfoTVCell: UITableViewCell {

    @IBOutlet weak var uilSWLITVCRiverName: UILabel!
    @IBOutlet weak var uilSWLITVCDatePost: UILabel!
    @IBOutlet weak var uilSWLITVCCriticalLevel: UILabel!
    @IBOutlet weak var uilSWLITVCCurrentLevel: UILabel!
    @IBOutlet weak var uilSWLITVCStatusLevel: UILabel!
    @IBOutlet weak var uiivSWLITVCIconLevel: UIImageView!
    
    
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
        uilSWLITVCRiverName.text = data.value(forKey: "WL_RIVER_NAME") as? String
        uilSWLITVCDatePost.text = data.value(forKey: "WL_POSTDATE") as? String
        uilSWLITVCCriticalLevel.text = data.value(forKey: "WL_CRITICALLEVEL") as? String
        uilSWLITVCCurrentLevel.text = data.value(forKey: "WL_CURRENTLEVEL") as? String
        uilSWLITVCStatusLevel.text = data.value(forKey: "WL_STATUSLEVEL") as? String
        
    }

}
