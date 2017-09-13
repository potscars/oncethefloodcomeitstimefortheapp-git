//
//  SaifonWLInfoTVController.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 09/06/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SaifonWLInfoTVController: UIViewController {
    
    var listAllArrays: NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let backButton: UIBarButtonItem = UIBarButtonItem.init(title: "Menu", style: UIBarButtonItemStyle.plain, target: self, action: #selector(backToMain))
        
        self.navigationItem.leftBarButtonItem = backButton
        
        let dataArrayFirstRiver: NSDictionary! =
            ["RIVER_NAME":"Sungai Tempasuk - Lebak Moyoh","RIVER_CURR_LEVEL":"8 m","RIVER_REPORT_DATE":"2016-06-16 12:38:46","RIVER_MAX_LEVEL":"30 m melepasi paras bahaya","RIVER_STATUS":"SELAMAT"]
        let dataArraySecondRiver: NSDictionary! =
            ["RIVER_NAME":"Sungai Tempasuk - Bobot","RIVER_CURR_LEVEL":"41.2 m","RIVER_REPORT_DATE":"2016-06-16 12:38:46","RIVER_MAX_LEVEL":"40 m melepasi paras bahaya","RIVER_STATUS":"BAHAYA"]
        let dataArrayThirdRiver: NSDictionary! =
            ["RIVER_NAME":"Sungai Piasau","RIVER_CURR_LEVEL":"8.81 m","RIVER_REPORT_DATE":"2016-06-16 12:38:46","RIVER_MAX_LEVEL":"20 m melepasi paras bahaya","RIVER_STATUS":"AMARAN"]
        
        listAllArrays = [dataArrayFirstRiver,dataArraySecondRiver,dataArrayThirdRiver]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backToMain()
    {
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
