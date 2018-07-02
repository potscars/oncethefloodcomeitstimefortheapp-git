//
//  TetapanTVC.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 19/07/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import MBProgressHUD
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}


class TetapanTVC: UITableViewController, UITextViewDelegate, UITextFieldDelegate {
    
    var settingsMenuArray: NSArray!
    var getCommentData: NSDictionary!
    var listOfDataArrays: NSMutableArray?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet var uitvTTVCAboutList: UITableView!
    
    var loadingSpinner: LoadingSpinner!
    var isFirstLoad = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshed(_:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            
            tableView.refreshControl = refreshControl
        } else {
            
            tableView.addSubview(refreshControl!)
        }
        
        uitvTTVCAboutList.dataSource = self
        
        self.edgesForExtendedLayout = UIRectEdge()
        uitvTTVCAboutList.rowHeight = UITableViewAutomaticDimension
        uitvTTVCAboutList.estimatedRowHeight = 404.0
        uitvTTVCAboutList.separatorStyle = .none
        
        settingsMenuArray = ["Hubungi Kami","Mengenai Kami","","Log Keluar"]
        
        self.loadingSpinner = LoadingSpinner.init(view: self.view, isNavBar: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.initLargeTitles()
        if(Libraries().CheckInternetConnection(self) == true)
        {
            let qualityOfServiceClass = DispatchQoS.QoSClass.background
            
            if listOfDataArrays?.count <= 0 {
                
                self.isFirstLoad = true
                self.loadingSpinner.setLoadingScreen()
                
                DispatchQueue.global(qos: qualityOfServiceClass).async(execute: { 
                    self.acquireAgenciesList()
                    
                    DispatchQueue.main.async(execute: { 
                        self.uitvTTVCAboutList.reloadData()
                    })
                })
            }
        } else {
            
            Alert().showAlert(self, title: "Amaran!", message: "Tiada talian rangkaian")
        }
    }

    func refreshed(_ sender: UIRefreshControl) {
        
        if(Libraries().CheckInternetConnection(self) == true)
        {
            let qualityOfServiceClass = DispatchQoS.QoSClass.background
            
            DispatchQueue.global(qos: qualityOfServiceClass).async(execute: {
                
                self.acquireAgenciesList()
            })
        } else {
            
            Alert().showAlert(self, title: "Amaran!", message: "Tiada talian rangkaian")
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        print("[TetapanTVC] Textview Begin Editing...")
        
        if(textView.text == "Tulis komen anda disini...")
        {
            textView.text = ""
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print("[TetapanTVC] TextView Should Return...")
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        
        print("[TetapanTVC] TextView Should End Editing...")
        
        textView.resignFirstResponder()
        
        return true
    }
    
    func sendComments(_ sender: UIButton!) {
        
        print("[TetapanTVC] Sending comments...")
        
    }
    
    func acquireAgenciesList() {
        
        print("[TetapanTVC] Getting Agencies List")
        
        let getLoginURL = URL.init(string: "http://saifon.my/api/list-agencies")
        
        print("[TetapanTVC] Requesting Agencies List...")
        
        let requestData = NSMutableURLRequest.init(url: getLoginURL!, cachePolicy:NSURLRequest.CachePolicy.useProtocolCachePolicy , timeoutInterval: 60.0)
        requestData.httpMethod = "GET"
        requestData.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        print("[TetapanTVC] Initiating session...")
        
        var loginDataFromJSON = NSArray()
        let loginSession = URLSession.shared
        let loginSessionDataTask: URLSessionDataTask = loginSession.dataTask(with: requestData as URLRequest) { (retrievedData ,response ,error) -> Void in
            do {
                
                print("[TetapanTVC] Retrieving response....")
                
                guard error == nil else {
                    Alert().showAlert(self, title: "Amaran!", message: "Ralat tidak dapat berhubung dengan server..")
                    self.endRefreshed()
                    self.removeSpinner()
                    return
                }
                
                guard let responseData = retrievedData else {
                    Alert().showAlert(self, title: "Amaran!", message: "Gagal mendapatkan data..")
                    self.endRefreshed()
                    self.removeSpinner()
                    return
                }
                
                loginDataFromJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as! NSArray
                
                let modifyJSONData = ["status":"successful","data":loginDataFromJSON] as [String : Any]
                
                print("[TetapanTVC] About Data Response in raw format is", modifyJSONData)
                
                self.setupAboutData(modifyJSONData as NSDictionary)
                
            }
            catch let error as NSError
            {
                print("[TetapanTVC] Error while retrieve login data ",error)
                
                let failedRetrieval = ["status":"failed","description":"ERROR_FROM_API"]
                
                self.setupAboutData(failedRetrieval as NSDictionary)
            }
        }
        
        loginSessionDataTask.resume()
    }

    func removeSpinner() {
        
        DispatchQueue.main.async {
            self.loadingSpinner.removeLoadingScreen()
        }
    }
    
    func endRefreshed() {
        
        if (refreshControl?.isRefreshing)! {
            
            refreshControl?.endRefreshing()
        }
    }
    
    func setupAboutData(_ apiData:NSDictionary)
    {
        print("[TetapanTVC] Setup About Data...")
        
        let status = apiData.value(forKey: "status") as! String
        let data = apiData.value(forKey: "data") as! NSArray
        var orgIconString = ""
        let countData = data.count - 1
        
        print("[TetapanTVC] Check status is", status)
        print("[TetapanTVC] Check Icon: ", ((data[0] as AnyObject).value(forKey: "profile")! as AnyObject).value(forKey: "thumbnail") ?? "")
        
        if(status == "successful")
        {
            print("[TetapanTVC] Data retrieval is successful")
            
            var dataArray0: NSDictionary = [:]
            
            for i in 0...countData {
                
                if let profile = (data[i] as AnyObject).value(forKey: "profile") as? NSDictionary, let thumbnail = profile.value(forKey: "thumbnail") as? NSDictionary {
                    
                    let domain = thumbnail.value(forKey: "domain") as! String
                    let path = thumbnail.value(forKey: "full_path") as! String
                    
                    orgIconString = "\(domain)\(path)"
                }
                
                dataArray0 = [
                    "ORG_NAME": String((data[i] as AnyObject).value(forKey: "name") as! String),
                    "ORG_EMAIL": String((data[i] as AnyObject).value(forKey: "email") as! String),
                    "ORG_PHONE_NO": String((data[i] as AnyObject).value(forKey: "phone_no") as! String),
                    "ORG_ICON": orgIconString
                ]
                
                print("[TetapanTVC] Data Array is ", dataArray0, " with ",i," from ",data.count)
                
                if(i == 0)
                {
                    self.listOfDataArrays = [dataArray0]
                }
                else{
                    self.listOfDataArrays!.add(dataArray0)
                }
            }
            
            //print("[TetapanTVC] First array inserted with data ", self.listOfDataArrays!)
            DispatchQueue.main.async {
                
                self.endRefreshed()
                self.loadingSpinner.removeLoadingScreen()
                self.uitvTTVCAboutList.reloadData()
            }
        }
        else
        {
            
            print("[SaifonVCController] Status is failed?")
            
            let errorDesc = apiData.value(forKey: "description") as! String
            let stringRange = errorDesc.startIndex ..< errorDesc.characters.index(errorDesc.startIndex, offsetBy: 20)
            
            let message = "Terdapat masalah. Sila cuba sebentar lagi. (ERRCODE:\(errorDesc.substring(with: stringRange)))"
            Alert().showAlert(self, title: "Amaran!", message: message)
            
            DispatchQueue.main.async {
                
                self.endRefreshed()
                self.loadingSpinner.removeLoadingScreen()
                self.uitvTTVCAboutList.reloadData()
            }
        }
    }
}

// MARK: - Table view data source

extension TetapanTVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return listOfDataArrays?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 0)
        {
            let aboutCell = tableView.dequeueReusableCell(withIdentifier: "AboutTitleCellIdentifier") as! TetapanTVCell
            
            return aboutCell
        }
        else
        {
            
            let orgCell = tableView.dequeueReusableCell(withIdentifier: "PautanCellIdentifier") as! TetapanTVCell
            orgCell.tag = indexPath.row
            orgCell.setOrganizationInfo(self.listOfDataArrays![indexPath.row] as! NSDictionary)
            tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            
            return orgCell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let phoneNo = (listOfDataArrays![indexPath.row] as AnyObject).value(forKey: "ORG_PHONE_NO") as! String
        let email = (listOfDataArrays![indexPath.row] as AnyObject).value(forKey: "ORG_EMAIL") as! String
        let orgName = (listOfDataArrays![indexPath.row] as AnyObject).value(forKey: "ORG_NAME") as! String
        
        let alertController: UIAlertController = UIAlertController(title: "Hubungi \(orgName)", message: "Sila pilih jenis perhubungan kepada pihak ini", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Batal", style: UIAlertActionStyle.cancel, handler: { (action) in
            
            print("[TetapanTVC] Call is cancelled ...")
            
        })
        
        alertController.addAction(cancelAction)
        
        let okAction: UIAlertAction = UIAlertAction(title: "Dail \(phoneNo)", style: UIAlertActionStyle.default, handler: { (action) in
            
            print("[TetapanTVC] Attempting to call \(phoneNo) ...")
            
            if let url = URL(string: "tel://\(phoneNo)") {
                UIApplication.shared.openURL(url)
                
            }
        })
        
        alertController.addAction(okAction)
        
        let emelAction: UIAlertAction = UIAlertAction(title: "Hantar Emel", style: UIAlertActionStyle.default, handler: { (action) in
            
            print("[TetapanTVC] Attempting to email \(email) ...")
            
            if let url = URL(string: "mailto://\(email)") {
                UIApplication.shared.openURL(url)
            }
        })
        
        alertController.addAction(emelAction)
        
        if(indexPath.row != 0)
        {
            self.present(alertController, animated: true, completion: {})
        }
    }
}















