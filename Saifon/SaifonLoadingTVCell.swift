//
//  SaifonLoadingTVCell.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 25/11/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SaifonLoadingTVCell: UITableViewCell {

    @IBOutlet weak var uilSLTVCLoadingDesc: UILabel!
    @IBOutlet weak var uilSTVCIndicator: UIActivityIndicatorView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setErrorLoading(_ data: NSDictionary) {
        
        uilSLTVCLoadingDesc.text = data.value(forKey: "LOADING_DESC") as? String
        uilSTVCIndicator.startAnimating()
        
    }

}
