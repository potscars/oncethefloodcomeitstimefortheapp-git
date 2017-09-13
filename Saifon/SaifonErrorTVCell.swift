//
//  SaifonErrorTVCell.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 29/08/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SaifonErrorTVCell: UITableViewCell {

    @IBOutlet weak var uilSETVCErrorDesc: UILabel!
    @IBOutlet weak var uiivSETVCIconImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func UpdateCell(_ data:NSDictionary) {
        
        print("[SaifonErrorTVCell] TempImage: \(data.value(forKey: "FEED_IMAGE"))")
        
        let tempImage: String = data.value(forKey: "FEED_IMAGE") as! String
        
        uilSETVCErrorDesc.text = data.value(forKey: "FEED_MAIN_TITLE") as? String
        uiivSETVCIconImage.image = UIImage(named: "\(tempImage)")
        
    }

}
