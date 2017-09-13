//
//  ProcessLoginController.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 01/06/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class ProcessLoginController: UIViewController {
    
    var loginDataDict:NSDictionary!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.performSegue(withIdentifier: "GOTO_MAIN", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "GOTO_MAIN")
        {
            //let destinationVC = segue.destinationViewController as! MainController
        }
    }
    

}
