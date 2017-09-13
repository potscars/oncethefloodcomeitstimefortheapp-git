//
//  LoginController.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 31/05/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import Bugsnag
import EAIntroView

class LoginController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var loginValue : UITextField!
    @IBOutlet var passwordValue : UITextField!
    @IBOutlet var nextButton : UIButton!
    @IBOutlet var loginButton : UIButton!
    @IBOutlet var loginView : UIView!
    @IBOutlet var passwordView : UIView!
    var loginData: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("[LoginController] Initiating login....");
        
        self.navigationController?.setNavigationBarHidden(true, animated: true);
        
        self.loginValue.delegate = self
        self.passwordValue.delegate = self
        self.passwordValue.isSecureTextEntry = true;
        
        let introPage1 = EAIntroPage()
        introPage1.title = "Security and Integrated Flood Operation Network"
        introPage1.bgImage = UIImage.init(named: "bg1")
        introPage1.titleIconView = UIImageView.init(image: UIImage.init(named: "saifonlogo_248"))
        introPage1.desc = "Meningkatkan penggunaan ICT dikalangan komuniti ke arah pembangunan sosio ekonomi masyarakat setempat"
        
        let introPage2 = EAIntroPage()
        introPage2.title = "Security and Integrated Flood Operation Network"
        introPage2.bgImage = UIImage.init(named: "bg2")
        introPage2.titleIconView = UIImageView.init(image: UIImage.init(named: "saifonlogo_248"))
        introPage2.desc = "Meningkatkan penggunaan ICT dikalangan komuniti ke arah pembangunan sosio ekonomi masyarakat setempat"
        
        let rect = CGRect(x: 0, y: 0, width: self.navigationController!.view.frame.width, height: self.navigationController!.view.frame.height)
        let introView = EAIntroView(frame: rect, andPages: [introPage1,introPage2])
        
        introView?.show(in: self.navigationController?.view,animateDuration: 0.3)
        
        nextButton.addTarget(self, action: #selector(checkLoginField(_:)), for: .touchUpInside)
        
        loginButton.addTarget(self, action: #selector(checkPasswordField(_:)), for: .touchUpInside)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateViewMoving(true, moveValue: 100)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(false, moveValue: 100)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.returnKeyType = UIReturnKeyType.done
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("[LoginController] TextFieldShouldReturn triggered...")
        textField.resignFirstResponder()
        return true
    }
    
    func animateViewMoving (_ up:Bool, moveValue: CGFloat)
    {
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }
    
    func checkLoginField(_ sender: UIButton)
    {
        print("[LoginController] Check Login Field...")
        
        UIView.transition(from: loginView, to: passwordView, duration: 2, options: UIViewAnimationOptions.curveEaseOut, completion: { (finished:Bool) -> () in })
        
    }
    
    func checkPasswordField(_ sender: UIButton)
    {
        print("[LoginController] Check Password Field...")
        
        self.performSegue(withIdentifier: "PROCESS_LOGIN", sender: self)
    }
    
    func processLogin()
    {
        
        loginData = ["username":""]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if(segue.identifier == "PROCESS_LOGIN")
        {
            let destinationVC = segue.destination as? ProcessLoginController
            destinationVC?.loginDataDict = loginData
        }
        
    }

}
