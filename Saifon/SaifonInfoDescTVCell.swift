//
//  SaifonInfoDescTVCell.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 09/06/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SaifonInfoDescTVCell: UITableViewCell {

    @IBOutlet weak var uiivSIDTVCIcon: UIImageView!
    @IBOutlet weak var uilSIDTVCSender: UILabel!
    @IBOutlet weak var uilSIDTVCDate: UILabel!
    @IBOutlet weak var uilSIDTVCDesc: UILabel!

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
        uilSIDTVCSender.text = data.value(forKey: "FEED_SENDER") as? String
        uilSIDTVCDate.text = data.value(forKey: "FEED_SENDER_DATE") as? String
        uilSIDTVCDesc.text = data.value(forKey: "FEED_FULL_DESC") as? String
        
        let getIconTempImage: NSDictionary = data.value(forKey: "FEED_SENDER_ICON") as! NSDictionary
        
        print("[SaifonInfoDescPicsTVCell] Received data is \(data)")
        
        let getURLIconImage: String = getIconTempImage.value(forKey: "IMAGE_ICON_DOMAIN_URL") as! String
        let getIconImage: String = getIconTempImage.value(forKey: "IMAGE_ICON_URLS") as! String
        var convertIconToString: String = ""
        
        if(getURLIconImage != "" || getIconImage != "")
        {
            convertIconToString = "\(getURLIconImage)\(getIconImage)"
        }
        else
        {
            convertIconToString = ""
        }
        
        
        if(data != [:]) {
            
            let imageUrl: URL = URL(string: convertIconToString)!
            
            DispatchQueue.global(qos: .default).async(execute: {
                
                let data: Data = try! Data(contentsOf: imageUrl)
                DispatchQueue.main.async(execute: {
                    
                    self.uiivSIDTVCIcon.image = UIImage(data: data)
                })
                
            })
        }
        else {
            
            self.uiivSIDTVCIcon.image = UIImage(named: "imagebrokenplaceholder.png")
        }

    }

}
