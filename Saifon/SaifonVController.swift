//
//  SaifonVController.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 01/06/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import EAIntroView
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

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class SaifonVController: UITableViewController {

    @IBOutlet var uitvSVCContentList: UITableView!
    var listAllArrays: NSMutableArray?
    var sendDataToDetails: NSDictionary?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var overallRiverData = NSArray()
    var defaultSeparatorColor: CGColor?
    
    var isScrolled = false
    var isFirstLoad = true
    var loadingSpinner: LoadingSpinner!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("[SaifonVController] Calling...")
        
        self.tabBarController?.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshed(_:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            
            tableView.refreshControl = refreshControl
        } else {
            
            tableView.addSubview(refreshControl!)
        }
        
        self.edgesForExtendedLayout = UIRectEdge()
        uitvSVCContentList.rowHeight = UITableViewAutomaticDimension
        uitvSVCContentList.estimatedRowHeight = 350.0
        
        //get Default SeparatorColor
        defaultSeparatorColor = tableView.separatorColor?.cgColor
        
        appDelegate.navigation = self.navigationItem
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        loadingSpinner = LoadingSpinner.init(view: self.view, isNavBar: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if(Libraries().CheckInternetConnection(self) == true)
        {
            if listAllArrays?.count <= 0 {
                
                self.isFirstLoad = true
                self.loadingSpinner.setLoadingScreen()
                let qualityOfService = DispatchQoS.QoSClass.background
                DispatchQueue.global(qos: qualityOfService).async(execute: {

                    self.GetFeedWaterLevelData(false)
                })
            }
        }
        else
        {

            Alert().showAlert(self, title: "Amaran!", message: "Tiada talian rangkaian")
            
            print("[SaifonVCController] No data found.")
            
            let dataArray1: NSDictionary! =
                ["SET_TABLECELL":"NO_INTERNET_CONNECTION",
                 "FEED_SENDER":"SYSTEM_ERROR" ,
                 "FEED_SENDER_CREDENTIAL":"SYSTEM",
                 "FEED_SENDER_DATE":"",
                 "FEED_MAIN_TITLE":"Tiada Sambungan Internet",
                 "FEED_MAIN_DESC":"",
                 "FEED_IMAGE":"ic_internet_noconn.png"
            ]
            self.listAllArrays = [dataArray1]
            self.loadingSpinner.removeLoadingScreen()
            self.tableView.reloadData()
        }
    }
    
    func displayTutorial()
    {
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
        
        //Show Intro here
        //introView.showInView(self.navigationController?.view,animateDuration: 0.3)
    }
    
    func refreshed(_ sender: UIRefreshControl) {
        
        if(Libraries().CheckInternetConnection(self) == true)
        {
            GetFeedWaterLevelData(true)
        }
        else
        {
            print("[SaifonVCController] No data found.")
            
            let dataArray1: NSDictionary! =
                ["SET_TABLECELL":"NO_INTERNET_CONNECTION",
                 "FEED_SENDER":"SYSTEM_ERROR" ,
                 "FEED_SENDER_CREDENTIAL":"SYSTEM",
                 "FEED_SENDER_DATE":"",
                 "FEED_MAIN_TITLE":"Tiada Sambungan Internet",
                 "FEED_MAIN_DESC":"",
                 "FEED_IMAGE":"ic_internet_noconn.png"
            ]
            self.listAllArrays = [dataArray1]
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
    func GetFeedWaterLevelData(_ refresh: Bool) {
        
        self.listAllArrays = []
        
        if refresh { listAllArrays?.removeAllObjects() }
        
        print("[SaifonVCController] Getting Water Level Data Feed")
        
        let getLoginURL = URL.init(string: URLs.kSAIFON_LANDING_PAGE_URL())
        
        print("[SaifonVCController] Requesting FeedWaterLevelData...")
        
        let requestData = NSMutableURLRequest.init(url: getLoginURL!, cachePolicy:NSURLRequest.CachePolicy.useProtocolCachePolicy , timeoutInterval: 60.0)
        requestData.httpMethod = "GET"
        requestData.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        print("[SaifonVCController] Initiating session...")
        
        var loginDataFromJSON = NSDictionary()
        
        let loginSession = URLSession.shared
        
        let loginSessionDataTask: URLSessionDataTask = loginSession.dataTask(with: requestData as URLRequest) { (retrievedData ,response ,error) -> Void in
            do {
                
                print("[SaifonVCController] Retrieving response....")
                
                guard error == nil else {
                    Alert().showAlert(self, title: "Amaran!", message: "Ralat tidak dapat berhubung dengan server..")
                    self.endRefreshed()
                    self.loadingSpinner.removeLoadingScreen()
                    
                    return
                }
                
                guard let responseData = retrievedData else {
                    Alert().showAlert(self, title: "Amaran!", message: "Gagal mendapatkan data..")
                    self.endRefreshed()
                    self.loadingSpinner.removeLoadingScreen()
                    return
                }
                
                loginDataFromJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as! NSDictionary
                
                print("[SaifonVCController] Feed Data Response in raw format is", loginDataFromJSON)
                
                self.SetupFeedData(loginDataFromJSON)
                
            }
            catch let error as NSError
            {
                print("[SaifonVCController] Error while retrieve login data ",error)
                
                loginDataFromJSON = ["status":"failed","description":"ERROR_FROM_API"]
                
                self.SetupFeedData(loginDataFromJSON)
            }
        }
        
        loginSessionDataTask.resume()
    }
    
    
    //MARK: - Setup data dari api masuk dalam variable tertentu
    func SetupFeedData(_ apiData: NSDictionary) {
        
        //FEEDER GUIDELINES:
        /*
         let dataArray1: NSDictionary! =
         ["SET_TABLECELL":"LATEST_FEED","FEED_SENDER":"Penghulu PI1M Demo" , "FEED_SENDER_CREDENTIAL":"AWAM", "FEED_SENDER_DATE":"April 14th, 2016", "FEED_MAIN_TITLE":"Aduan Kenaikan Bil Elektrik", "FEED_MAIN_DESC":"Perhatian kepada semua penduduk Kampung Demo, pihak Syarikat Air Demo Berhad akan membuat pemotongan bekalan air ke kampung ini disebabkan semua orang kampung tidak membuat pembayaran air. Perhatian kepada semua penduduk Kampung Demo, pihak Syarikat Air Demo Berhad akan membuat pemotongan bekalan air ke kampung ini disebabkan semua orang kampung tidak membuat pembayaran air. ", "FEED_IMAGE":""]
         
         let dataArray1: NSDictionary! =
         ["SET_TABLECELL":"LATEST_FEED", "FEED_SENDER":"Penghulu PI1M Demo" , "FEED_SENDER_CREDENTIAL":"AWAM", "FEED_SENDER_DATE":feedsOnData!.valueForKey("updated_at"), "FEED_MAIN_TITLE":"Latest Feed", "FEED_MAIN_DESC":feedsOnData!.valueForKey("content"), "FEED_IMAGE":""]
         */
        
        print("[SaifonVCController] Getting Water Level Data Feed")
        
        let status = apiData.value(forKey: "status") as! String
        
        print("[SaifonVCController] Check status is", status)
        
        if(status == "succesful")
        {
            print("[SaifonVCController] Data retrieval is successful")
            
            let data = apiData.value(forKey: "data") as! NSDictionary
            print("[SaifonVCController] Check status is", data)
            
            let feeds = data.value(forKey: "feeds") as? NSArray
            let finalFeeds = (feeds != nil) ? feeds : []
            print("[SaifonVCController] Check feedsOnData is", finalFeeds)
            
            let dataArray0: NSDictionary = [
                "SET_TABLECELL":"RIVER_STATUS",
                "RIVER_NAME":(data.value(forKey: "location") as? String)!,
                "RIVER_REPORT_DATE":(data.value(forKey: "date_sent") as? String)!,
                "RIVER_DIFFERENCE_DIRECTION":data.value(forKey: "different_type")! as AnyObject,
                "RIVER_LEVEL_PREVIOUS":Libraries.checkIfStringOrInt(data.value(forKey: "different")! as AnyObject),
                "RIVER_LEVEL_DIFFERENCE":(data.value(forKey: "interval_different") as? String)!,
                "RIVER_CURR_LEVEL":(data.value(forKey: "waterDeep") as? String)!,
                "RIVER_LEVEL_PHASE":(data.value(forKey: "level_phase") as? Int)!,
                "RIVER_LEVEL_STATUS":(data.value(forKey: "level_status") as? String)!
            ]
            
            //print("[SaifonVCController] Data Array is ", dataArray0)
            
            //self.listAllArrays = [dataArray0]

            if(feeds != nil)
            {
                print("[SaifonVCController] Place feeds in array with content: \(feeds)...")
                
                let dateSender: NSArray = feeds!.value(forKey: "updated_at") as! NSArray
                let mainDesc: NSArray = feeds!.value(forKey: "content") as! NSArray
                let imagesList: NSArray = feeds!.value(forKey: "images") as! NSArray
                let userProfile: NSArray = feeds!.value(forKey: "user_profile") as! NSArray
                let user: NSArray = feeds!.value(forKey: "user") as! NSArray
                
                for i in 0...feeds!.count - 1
                {
                    let tempArray: NSDictionary = [
                        "IMAGE_DOMAIN_URL":((imagesList[i] as AnyObject).value(forKey: "large")! as AnyObject).value(forKey: "domain")! as! NSArray,
                    "IMAGE_URLS":((imagesList[i] as AnyObject).value(forKey: "large")! as AnyObject).value(forKey: "full_path")! as! NSArray]
                    
                    let tempIconArray: NSDictionary = [
                    
                        "IMAGE_ICON_DOMAIN_URL":((userProfile[i] as AnyObject).value(forKey: "thumbnail")! as AnyObject).value(forKey: "domain") as! String,
                        "IMAGE_ICON_URLS":((userProfile[i] as AnyObject).value(forKey: "thumbnail")! as AnyObject).value(forKey: "full_path") as! String
                        
                    ]
                    //print("[SaifonVCController] Image inserted: \(tempArray[0])")
                    
                    let mainDescString = mainDesc[i] as! String
                    let start = mainDescString.index(mainDescString.startIndex, offsetBy: 0)
                    let end = mainDescString.index(mainDescString.startIndex, offsetBy: mainDescString.characters.count > 100 ? 100 : mainDescString.characters.count)
                    let range = start..<end
                    
                    let dataArray1: NSDictionary! =
                        ["SET_TABLECELL":"LATEST_FEED",
                         "FEED_SENDER":(user[i] as AnyObject).value(forKey: "name") as! NSString,
                         "FEED_SENDER_ICON":tempIconArray,
                         "FEED_SENDER_CREDENTIAL":"AWAM",
                         "FEED_SENDER_DATE":dateSender[i],
                         "FEED_MAIN_TITLE":"",
                         "FEED_MAIN_DESC":"\(mainDescString.substring(with: range))...",
                         "FEED_FULL_DESC":"\(mainDesc[i])",
                         "FEED_IMAGE":tempArray
                    ]
                    
                    if(self.listAllArrays != nil) {
                        
                        print("[SaifonVCController] Arrays available more than 0 \(self.listAllArrays?.count).")
                        
                        self.listAllArrays?.add(dataArray1)
                        
                    }
                    else{
                        
                        print("[SaifonVCController] Arrays not available. Initiating....")
                        
                        self.listAllArrays = [dataArray1]
                        
                    }
                }
            }
            else
            {
                print("[SaifonVCController] No data found.")
                
                let errorImgArray: NSDictionary = ["IMAGE_DOMAIN_URL":"none","IMAGE_URLS":"ic_error.png"]
                
                let dataArray1: NSDictionary! =
                    ["SET_TABLECELL":"NO_FEED",
                     "FEED_SENDER":"SYSTEM_ERROR" ,
                     "FEED_SENDER_ICON":"",
                     "FEED_SENDER_CREDENTIAL":"SYSTEM",
                     "FEED_SENDER_DATE":"",
                     "FEED_MAIN_TITLE":"Tiada Pengumuman",
                     "FEED_MAIN_DESC":"",
                     "FEED_FULL_DESC":"",
                     "FEED_IMAGE":errorImgArray
                ]
                self.listAllArrays = [dataArray1]
            }
        }
        else
        {
            
            print("[SaifonVCController] Status is failed?")
            
            let errorDesc = apiData.value(forKey: "description") as! String
            let stringRange = errorDesc.startIndex ..< errorDesc.characters.index(errorDesc.startIndex, offsetBy: 20)
  
            let message = "Terdapat masalah. Sila cuba sebentar lagi. (ERRCODE:\(errorDesc.substring(with: stringRange)))"
            self.appearOKAlert("Masalah", message: message, okBtnTitle: "OK")
            
            DispatchQueue.main.async {
                self.uitvSVCContentList.isHidden = true
            }
        }
        
        if (refreshControl?.isRefreshing)! {
            
            refreshControl?.endRefreshing()
        }
        
        
        DispatchQueue.main.async {
            self.uitvSVCContentList.isHidden = false
            self.uitvSVCContentList.reloadData()
            
            if self.isFirstLoad {
             
                self.isFirstLoad = false
                self.loadingSpinner.removeLoadingScreen()
            }
        }
    }
    
    /*func GetOverallWaterLevelData(_ amount: String)
    {
        print("[SaifonVCController] Getting Overall Water Level Data Feed")
        
        let getLoginURL = URL.init(string: URLs.kSAIFON_WATER_LEVEL_DATA_URL(amount))
        
        print("[SaifonVCController] Requesting GetOverallWaterLevelData...")
        
        let requestData = NSMutableURLRequest.init(url: getLoginURL!, cachePolicy:NSURLRequest.CachePolicy.useProtocolCachePolicy , timeoutInterval: 60.0)
        requestData.httpMethod = "GET"
        requestData.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        print("[SaifonVCController] Initiating GetOverallWaterLevelData...")
        
        let getDataSession = URLSession.shared
        var successMessage: String = ""
        //var dataArray0: NSDictionary!
        let getDataSessionDataTask: URLSessionDataTask = getDataSession.dataTask(with: requestData as URLRequest) { (retrievedData, response, error) -> Void in
            
            do {
                
                guard error == nil else {
                    Alert().showAlert(self, title: "Amaran!", message: "Ralat tidak dapat berhubung dengan server..")
                    self.removeSpinner()
                    return
                }
                
                guard let responseData = retrievedData else {
                    Alert().showAlert(self, title: "Amaran!", message: "Gagal mendapatkan data..")
                    
                    return
                }
     
                let getDataFromJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as! NSArray
                
                self.overallRiverData = getDataFromJSON
                
                print("[SaifonVCController] Check data: ",getDataFromJSON)
                
                successMessage = (getDataFromJSON.object(at: 0) as AnyObject).value(forKey: "location") as! String
                
                print("[SaifonVCController] Success message is ",successMessage)
                print("[SaifonVCController] Data retrieved is ",retrievedData)
                
                let data = getDataFromJSON.value(forKey: "receives")
                
                print("[SaifonVCController] Check status is", data)
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "SAIFON_WL_INFO_SEGUE", sender: self)
                }
                
            }
            catch let error as NSError {
                
                print("[SaifonVCController] Error while retrieve login data ",error)
            }
        }
        
        getDataSessionDataTask.resume()

    }*/
    
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
    
    func appearOKAlert(_ title: String, message: String, okBtnTitle: String)
    {
        
        print("[SaifonVCController] Appearing OK Alert")
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: okBtnTitle, style: UIAlertActionStyle.default, handler: {(action: UIAlertAction) -> Void in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let countArrays = ((listAllArrays?.count) != nil) ? listAllArrays?.count : 0
        
        print("[SaifonVController] Numberofrowsinsection in countarrays \(countArrays)")
        
        if(countArrays == 0)
        {
            return 1
        }
        else
        {
            return (countArrays)!
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("[SaifonVCController] Check if cellForRowAtIndexPath is initiating...")
        var tableCell: String? = "FEED_LOADING"
        var checkFeedArray: NSArray? = []
        var checkListArray: NSDictionary? = [:]
        
        if(listAllArrays != [])
        {
            checkListArray = listAllArrays?[indexPath.row] as! NSDictionary?
        }
        else
        {
            checkListArray = [:]
        }
        
        if(checkListArray != [:])
        {
            tableCell = (listAllArrays?[indexPath.row] as AnyObject).value(forKey: "SET_TABLECELL") as? String
            let feedImg = (listAllArrays?[indexPath.row] as AnyObject).value(forKey: "FEED_IMAGE") as? NSDictionary
            
            checkFeedArray = feedImg?.value(forKey: "IMAGE_DOMAIN_URL") as! NSArray?
            
            if(checkFeedArray != nil) {
            
                checkFeedArray = feedImg?.value(forKey: "IMAGE_DOMAIN_URL") as? NSArray
            }
            else{
            
                checkFeedArray = []
            }
        }
        
        let cell: SaifonLoadingTVCell = tableView.dequeueReusableCell(withIdentifier: "LoadingFeedCellIdentifier") as! SaifonLoadingTVCell
        
        cell.tag = indexPath.row
        
        if(tableCell == "RIVER_STATUS")
        {
            let cellStatus: SaifonVCCell = tableView.dequeueReusableCell(withIdentifier: "SaifonCellIdentifier") as! SaifonVCCell
            cellStatus.UpdateCell(checkListArray!)
            return cellStatus
        }
        else if(tableCell == "LATEST_FEED" && checkFeedArray!.count != 0)
        {
            tableView.separatorColor = UIColor.init(cgColor: defaultSeparatorColor!)
            
            let cellPicFeed: SaifonInfoPicVCCell = tableView.dequeueReusableCell(withIdentifier: "FeedWithPicCellIdentifier") as! SaifonInfoPicVCCell
            
            let dataMain: NSDictionary = checkListArray!
            
            print("[SaifonVController] Main Data: ",listAllArrays![1] as! NSDictionary)
            
            let getTempImage: NSDictionary = dataMain.value(forKey: "FEED_IMAGE") as! NSDictionary
            
            print("[SaifonVController] Temporary Image: ",getTempImage)
            
            let getIconTempImage: NSDictionary = dataMain.value(forKey: "FEED_SENDER_ICON") as! NSDictionary
            
            print("[SaifonVController] Temporary Icon Image: ",getIconTempImage)
            
            let getURLImage: NSArray = getTempImage.value(forKey: "IMAGE_DOMAIN_URL") as! NSArray
            print("[SaifonVController] URI-Image: ",getURLImage)
            let getImage: NSArray = getTempImage.value(forKey: "IMAGE_URLS") as! NSArray
            print("[SaifonVController] Image: ",getImage)
            
            var convertURLImageToString: String? = ""
            
            if(getURLImage.count != 0)
            {
                print("[SaifonVController] URI IMAGE GRABBED: ",getURLImage[0])
                convertURLImageToString = getURLImage[0] as? String
            }
            
            var convertImageToString: String? = ""
            
            if(getImage.count != 0)
            {
                convertImageToString = getImage[0] as? String
            }
            
            var convertToString: String = ""
            
            if(convertURLImageToString != nil || convertImageToString != nil)
            {
                convertToString = "\(convertURLImageToString!)\(convertImageToString!)"
            }
            else
            {
                convertToString = ""
            }
            
            print("[SaifonVController] Got string: ",convertToString)
            
            let getURLIconImage: String = getIconTempImage.value(forKey: "IMAGE_ICON_DOMAIN_URL") as! String
            let getIconImage: String = getIconTempImage.value(forKey: "IMAGE_ICON_URLS") as! String
            var convertIconToString: String = ""
            
            if(getURLIconImage != "" || getIconImage != "")
            {
                convertIconToString = "\(getURLIconImage)\(getIconImage)"
            }
            else
            {
                convertIconToString = ""
            }
            
            print("[SaifonVController] Converted Images",convertIconToString)
            
            if(convertToString != "") {
                
                let imageUrl: URL = URL(string: convertToString)!
                cellPicFeed.displayFeedImage(imageUrl)
            }
            
            if(convertIconToString != "") {
                
                let imageUrl: URL = URL(string: convertIconToString)!
                cellPicFeed.displayFeedIcon(imageUrl)
            }
                
            cellPicFeed.UpdateCell(listAllArrays![indexPath.row] as! NSDictionary)
            
            tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
                
            return cellPicFeed
        }
        else if(tableCell == "LATEST_FEED" && checkFeedArray!.count == 0)
        {
            tableView.separatorColor = UIColor.init(cgColor: defaultSeparatorColor!)
            
            let cellFeed: SaifonInfoVCCell = tableView.dequeueReusableCell(withIdentifier: "FeedCellIdentifier") as! SaifonInfoVCCell
            
            cellFeed.UpdateCell(listAllArrays![indexPath.row] as! NSDictionary)
            
            tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            
            return cellFeed
        }
        else if(tableCell == "NO_FEED" || tableCell == "NO_INTERNET_CONNECTION")
        {
            tableView.separatorColor = UIColor.clear
            
            let cellErrorFeed: SaifonErrorTVCell = tableView.dequeueReusableCell(withIdentifier: "ErrorCellIdentifier") as! SaifonErrorTVCell
            
            cellErrorFeed.UpdateCell(listAllArrays![indexPath.row] as! NSDictionary)
            
            tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            
            return cellErrorFeed
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let tableCell = (listAllArrays![indexPath.row] as AnyObject).value(forKey: "SET_TABLECELL") as! String
        
        //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0),{
            
            //MBProgressHUD.hideHUDForView(self.view, animated: true)
            
        //    }
        //)
        
        /* if(indexPath.row == 0 && (tableCell != "NO_FEED" && tableCell != "NO_INTERNET_CONNECTION"))
        {
            self.displayProgress(MBProgressHUDAnimation.Fade,labelText: "Sila tunggu. Sedang memuatkan...")
            GetOverallWaterLevelData("10")
        }
        else */
        switch tableCell {
            
        case "RIVER_STATUS":
            
            print("RIVER_STATUS!")
            break;
            
        case "LATEST_FEED":
            
            sendDataToDetails = listAllArrays![indexPath.row] as? NSDictionary
            performSegue(withIdentifier: "SAIFON_INFO_DESC_SEGUE", sender: self)
            print("[SaifonVController] Check data details sent is ",sendDataToDetails)
            break;
            
        default:
            break
            
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "SAIFON_INFO_DESC_SEGUE")
        {
            print("[SaifonVController] SAIFON_INFO_DESC_SEGUE called")
            let destinationVC = segue.destination as? SaifonInfoDetailsTVController
            destinationVC?.descDetails = sendDataToDetails
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        isScrolled = true
    }
}

private extension UITableView {
    
    func scrollToTop() {
        
        self.setContentOffset(CGPoint(x: 0,y: 0 - self.contentInset.top) , animated: true)
    }
}

extension SaifonVController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if viewController == self {
            
            if isScrolled {
                
                tableView.scrollToTop()
                isScrolled = false
            }
        }
    }
}




































