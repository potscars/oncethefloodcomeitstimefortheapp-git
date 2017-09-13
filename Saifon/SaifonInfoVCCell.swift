//
//  SaifonInfoVCCell.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 02/06/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SaifonInfoVCCell: UITableViewCell {

    @IBOutlet weak var uivSIVCCUDescView: UIView!
    @IBOutlet weak var uiivSIVCIcon: UIImageView!
    @IBOutlet weak var uilSIVCCSender: UILabel!
    @IBOutlet weak var uilSIVCCSenderDate: UILabel!
    @IBOutlet weak var uilSIVCCMainDesc: UILabel!
    
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
        uilSIVCCSender.text = data.value(forKey: "FEED_SENDER") as? String
        uilSIVCCSenderDate.text = data.value(forKey: "FEED_SENDER_DATE") as? String
        uilSIVCCMainDesc.text = data.value(forKey: "FEED_MAIN_DESC") as? String
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SaifonInfoVCCell.handleTapper(_:)))
        uilSIVCCMainDesc.addGestureRecognizer(tapGesture)
        
    
        //uilSIVCCMainDesc.t
        
        //uilSIVCCMainDesc.sizeToFit()
        //uilSIVCCMainDesc.adjustsFontSizeToFitWidth = true
        
        //uilSIVCCMainDesc.sizeThatFits(CGSize(width: 310,height: 310))
        
        //resizeToFitSubViews()
        
        //var frame = CGRect?()
        //let contentSize = uilSIVCCMainDesc.sizeThatFits(uilSIVCCMainDesc.bounds.size)
        //frame = uilSIVCCMainDesc.frame
        //frame?.size.height = contentSize.height
        
        //print("Frame Before Change: ",uilSIVCCMainDesc.frame.height)
        //uilSIVCCMainDesc.frame = frame!
        //uivSIVCCUDescView.frame = frame!
        
        //print("Frame: ",frame?.height)
        
        //print("Frame After Change: ",uilSIVCCMainDesc.frame.height)
        
    }
    
    func handleTapper(_ recognizer: UITapGestureRecognizer)
    {
        print("[SaifonInfoVCCell] Handle Tapped")
    }
    
    func resizeToFitSubViews()
    {
        var w = CGFloat()
        var h = CGFloat()
        
        w = 0
        h = 0
        
        for view in self.uivSIVCCUDescView.subviews {
            
            var fw = CGFloat()
            var fh = CGFloat()
            fw = view.frame.origin.x + view.frame.size.width
            fh = view.frame.origin.y + view.frame.size.height
            w = max(fw, w)
            h = max(fh, h)
        }
        
        uilSIVCCMainDesc.frame = CGRect(x: uilSIVCCMainDesc.frame.origin.x, y: uilSIVCCMainDesc.frame.origin.y, width: w, height: h)
    }

}


extension NSAttributedString {
    
    func heightWithConstrainedWidth(_ width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func widthWithConstrainedHeight(_ height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
    
}
