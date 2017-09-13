//
//  InitialNavController.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 24/11/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class InitialNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("[InitialNavController] Initiating navigation controller")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationBar.barTintColor = UIColor(red: CGFloat(42/255.0), green: CGFloat(43/255.0), blue: CGFloat(60/255.0), alpha: CGFloat(1.0))
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(hue: CGFloat(1.00), saturation: CGFloat(0.84), brightness: CGFloat(0.81), alpha: CGFloat(1.00)),NSFontAttributeName:UIFont.init(name: "Arial-BoldMT", size: CGFloat(17.0))!]
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
