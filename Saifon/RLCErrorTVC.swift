//
//  RLCErrorTVC.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 05/10/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class RLCErrorTVC: UITableViewCell {

    @IBOutlet weak var uilETVCErrorNote: UILabel!
    @IBOutlet weak var uiivETVCErrorIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ _selected: Bool, animated: Bool) {
        super.setSelected(isSelected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setErrorInfo(_ data: NSDictionary)
    {
        let errCode = data.value(forKey: "ERR_CODE") as! String
        
        if(errCode == "NO_INTERNET_CONNECTION")
        {
            uilETVCErrorNote.text = "Tiada Sambungan Internet"
            uiivETVCErrorIcon.image = UIImage(named: "ic_internet_noconn")
        }
        else if(errCode == "NO_DATA")
        {
            uilETVCErrorNote.text = "Tiada Maklumat"
            uiivETVCErrorIcon.image = UIImage(named: "ic_error")
        }
        else
        {
            uilETVCErrorNote.text = "Terdapat Masalah"
            uiivETVCErrorIcon.image = UIImage(named: "ic_error")
        }
    }

}
