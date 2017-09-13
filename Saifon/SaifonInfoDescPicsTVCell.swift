//
//  SaifonInfoDescPicsTVCell.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 23/06/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SaifonInfoDescPicsTVCell: UITableViewCell {
    
    @IBOutlet weak var uiivSIDPTVCDescImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func UpdateCell(_ data:String)
    {
        print("[SaifonInfoDescPicsTVCell] Received data is \(data)")
        
        if(data != "") {
            
            let imageUrl: URL = URL(string: data)!
            
            DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default).async(execute: {
                
                let data: Data = try! Data(contentsOf: imageUrl)
                DispatchQueue.main.async(execute: {
                    
                    
                    self.uiivSIDPTVCDescImage.image = UIImage(data: data)
                    
                    
                })
                
            })
        }
        else
        {
            self.uiivSIDPTVCDescImage.image = UIImage(named: "imagebrokenplaceholder.png")
        }
        
        
    }

}
