//
//  MainTabController.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 01/06/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import EAIntroView
import MBProgressHUD

class MainTabController: UITabBarController, MBProgressHUDDelegate {
    
    var ProgressHUD = MBProgressHUD()
    static var initialOverallWaterLevel: NSMutableArray = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        
        //self.selectedIndex = 1
        
        //WebServices.GetOverallWaterLevelData(dataAmount: "10")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("[MainController] Appearing...")
        
        self.navigationItem.title = "S.A.I.F.O.N."
        self.navigationItem.hidesBackButton = true
        self.navigationController?.initLargeTitles()
        
        UITabBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().barTintColor = UIColor(red: CGFloat(42/255.0), green: CGFloat(43/255.0), blue: CGFloat(60/255.0), alpha: CGFloat(1.0))
        
    }
    
    func displayProgress(_ animType:MBProgressHUDAnimation, labelText:String) {
        
        print("[SaifonVCController] Showing Progress Bar...")
        
        ProgressHUD = MBProgressHUD.showAdded(to: self.view.window!, animated: true)
        ProgressHUD.animationType = animType
        ProgressHUD.label.text = labelText
        ProgressHUD.label.font = UIFont.init(name: "Arial", size: CGFloat(12))
        ProgressHUD.delegate = self
    }

}
































