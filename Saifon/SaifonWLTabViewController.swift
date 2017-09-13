//
//  SaifonWLTabViewController.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 18/08/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SaifonWLTabViewController: UITabBarController {

    var sungai1 = NSDictionary()
    var sungai1Details = NSDictionary()
    var sungai2 = NSDictionary()
    var sungai2Details = NSDictionary()
    var sungai3 = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("[SaifonWLTabViewController] First River Data: ",sungai1)
        print("[SaifonWLTabViewController] Second River Data: ",sungai2)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
