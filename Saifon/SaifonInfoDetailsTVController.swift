//
//  SaifonInfoDetailsTVController.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 09/06/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SaifonInfoDetailsTVController: UITableViewController {
    
    var descDetails: NSDictionary!
    @IBOutlet var uitvSIDTVCContents: UITableView!
    var rowsCount: NSInteger! = 1
    var imgArrays: NSMutableArray? = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        print("[SaifonInfoDetailsTVController] Details passed is", descDetails)
        
        self.edgesForExtendedLayout = UIRectEdge()
        uitvSIDTVCContents.rowHeight = UITableViewAutomaticDimension
        uitvSIDTVCContents.estimatedRowHeight = 350.0
        uitvSIDTVCContents.separatorColor = UIColor.clear
        
        let getImageDict: NSDictionary? = descDetails.value(forKey: "FEED_IMAGE") as? NSDictionary
        let getURLImage: NSArray = getImageDict?.value(forKey: "IMAGE_DOMAIN_URL") as! NSArray
        let feedImgArray: NSArray = getImageDict?.value(forKey: "IMAGE_URLS") as! NSArray
        
        imgArrays?.add("[IMAGES INITIAL]")
        
        print("[SaifonInfoDetailsTVController] Is there any count on feedImgArray? : \(feedImgArray.count)")
        
        if(feedImgArray.count != 0)
        {
            for i in 0...feedImgArray.count - 1 {
            
                let convertURLImageToString: String? = getURLImage[i] as? String
                let convertImageToString: String? = feedImgArray[i] as? String
                var convertToString: String = ""
            
                if(convertURLImageToString != nil || convertImageToString != nil)
                {
                    convertToString = "\(getURLImage[i])\(feedImgArray[i])"
                }
                else
                {
                    convertToString = ""
                }
            
                imgArrays?.add(convertToString)
            }
        }
        
        print("[SaifonInfoDetailsTVController] FEED_IMAGE count is ", imgArrays?.count)
        print("[SaifonInfoDetailsTVController] IMGARRAYS is \(imgArrays)")
        
        if(getImageDict?.count != nil)
        {
            //rowsCount = rowsCount + (imgArrays?.count)! [KOD ASAL]
            rowsCount = imgArrays!.count
        }
        else if(descDetails.value(forKey: "FEED_IMAGE") as? String != "")
        {
            rowsCount = rowsCount + 1
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if(rowsCount > 1)
        {
            return rowsCount
        }
        else
        {
            return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SaifonInfoDescCellIdentifier") as! SaifonInfoDescTVCell
        
        if(indexPath.row == 0)
        {
            // Configure the cell...
            cell.UpdateCell(descDetails as NSDictionary)
        }
        else if((descDetails.value(forKey: "FEED_IMAGE") as? NSArray) != nil || descDetails.value(forKey: "FEED_IMAGE") as? String != "")
        {
            let cellWithPics = tableView.dequeueReusableCell(withIdentifier: "SaifonInfoDescPicsCellID") as! SaifonInfoDescPicsTVCell
            
            cellWithPics.UpdateCell(imgArrays![indexPath.row] as! String)
            
            return cellWithPics
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}




















