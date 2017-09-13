//
//  TetapanTVCell.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 20/07/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import SDWebImage

class TetapanTVCell: UITableViewCell {

    @IBOutlet weak var uilTTVCMenuContent: UILabel!
    
    @IBOutlet weak var uitfTTVCSenderName: UITextField!
    @IBOutlet weak var uitfTTVCSenderEmail: UITextField!
    @IBOutlet weak var uitfTTVCSenderPhone: UITextField!
    @IBOutlet weak var uitfTTVCSenderComment: UITextView!
    @IBOutlet weak var uitfTTVCSenderSentBtn: UIButton!
    
    
    @IBOutlet weak var uiivTTVCOrgIcon: UIImageView!
    @IBOutlet weak var uilTTVCOrgName: UILabel!
    @IBOutlet weak var uilTTVCOrgEmail: UILabel!
    @IBOutlet weak var uilTTVCOrgPhoneNo: UILabel!
    
    
    @IBOutlet weak var uilTTVCErrorDesc: UILabel!
    @IBOutlet weak var uilTTVCErrorIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func GetCommentData() -> NSDictionary
    {
        let sendData: NSDictionary = ["Comments_SenderName":uitfTTVCSenderName.text!,"Comments_SenderEmail":uitfTTVCSenderEmail.text!,"Comments_SenderPhone":uitfTTVCSenderPhone.text!,"Comments_SenderComment":uitfTTVCSenderComment.text!,"Comments_SenderButton":uitfTTVCSenderSentBtn]
        
        return sendData
    }
    
    func setOrganizationInfo(_ data:NSDictionary)
    {
        uilTTVCOrgName.text = data.value(forKey: "ORG_NAME") as? String
        uilTTVCOrgEmail.text = data.value(forKey: "ORG_EMAIL") as? String
        uilTTVCOrgPhoneNo.text = data.value(forKey: "ORG_PHONE_NO") as? String
        
        let urlString = data.value(forKey: "ORG_ICON") as! String
        let url = URL(string: urlString)!
        
        DispatchQueue.main.async { 
            self.uiivTTVCOrgIcon.sd_setImage(with: url)
        }
    }
    
    func setOrganizationIcon(_ image: UIImage?)
    {
        print("[TetapanTVCell] ImageData: ",image)
        
        if (image != nil) {
            
            self.uiivTTVCOrgIcon.image = image
        }
    }
    
    func setErrorInfo(_ data:NSDictionary)
    {
        let errCode = data.value(forKey: "ERR_CODE") as! String
        
        if(errCode == "NO_INTERNET_CONNECTION")
        {
            uilTTVCErrorDesc.text = "Tiada Sambungan Internet"
            uilTTVCErrorIcon.image = UIImage(named: "ic_internet_noconn")
        }
        else if(errCode == "NO_DATA")
        {
            uilTTVCErrorDesc.text = "Tiada Maklumat"
            uilTTVCErrorIcon.image = UIImage(named: "ic_error")
        }
        else
        {
            uilTTVCErrorDesc.text = "Terdapat Masalah"
            uilTTVCErrorIcon.image = UIImage(named: "ic_error")
        }
    }
}
