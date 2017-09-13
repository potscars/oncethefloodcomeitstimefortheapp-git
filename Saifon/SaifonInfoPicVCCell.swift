//
//  SaifonInfoPicVCCell.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 06/06/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import SDWebImage

class SaifonInfoPicVCCell: UITableViewCell {

    @IBOutlet weak var uiivSIPVCCIconImg: UIImageView!
    @IBOutlet weak var uilSIPVCCSenderName: UILabel!
    @IBOutlet weak var uilSIPVCCSentDate: UILabel!
    @IBOutlet weak var uilSIPVCCMainDesc: UILabel!
    @IBOutlet weak var uiivSIPVCCFeedImage: UIImageView!
    
    
    
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
        
        uilSIPVCCSenderName.text = data.value(forKey: "FEED_SENDER") as? String
        uilSIPVCCSentDate.text = data.value(forKey: "FEED_SENDER_DATE") as? String
        uilSIPVCCMainDesc.text = data.value(forKey: "FEED_MAIN_DESC") as? String
    }
    
    func displayFeedIcon(_ url: URL?)
    {

        DispatchQueue.main.async {
            self.uiivSIPVCCIconImg.sd_setImage(with: url)
        }
    }
    
    func displayFeedImage(_ url: URL?)
    {
        DispatchQueue.main.async { 
            self.uiivSIPVCCFeedImage.sd_setImage(with: url)
        }
    }

}
