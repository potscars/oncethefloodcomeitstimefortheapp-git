//
//  RiverListController.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 05/10/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import MBProgressHUD

struct RiverIdentifier {
    static let RiverLevelGraphCellIdentifier = "riverGraphCellIdentifier"
}

class RiverListController: UITableViewController, MBProgressHUDDelegate {

    var listOfRivers: NSMutableArray? = []
    var selectedRiverDetails: NSDictionary = [:]
    var receivedListofRivers: NSMutableArray = []
    var allRiverData: NSMutableArray = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var receivedID: String = ""
    var listTotalAmount = "20"
    
    var isFirstLoad = true
    var loadingSpinner: LoadingSpinner!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshed(_:)), for: .valueChanged)
        
        if #available(iOS 10.0, *) {
            
            tableView.refreshControl = refreshControl
        } else {
            
            tableView.addSubview(refreshControl!)
        }
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 140.0
        tableView.register(PlaceHolderCell.self, forCellReuseIdentifier: "PlaceholderCell")
        edgesForExtendedLayout = UIRectEdge()
        
        loadingSpinner = LoadingSpinner.init(view: self.view, isNavBar: true)
        
        /* Example data
        let exampleData: NSDictionary = ["RIVER_STATUS":"RIVER_IN_DANGER_MODE",
                                         "RIVER_NAME":"Sungai Abai - Kg. Sembirai",
                                         "RIVER_REPORT_DATE":"02 November 2016, 5:55:55 PM",
                                         "RIVER_CURRENT_LEVEL":"3.89m",
                                         "RIVER_DIFFERENCE":"-0.02m",
                                         "RIVER_PREVIOUS_LEVEL":"3.87m"]
        
        listOfRivers.addObject(exampleData)
        
        let exampleData2: NSDictionary = ["RIVER_STATUS":"RIVER_IN_SAFE_MODE",
                                         "RIVER_NAME":"Sungai Tempasuk - Kg. Bobot",
                                         "RIVER_REPORT_DATE":"02 November 2016, 5:55:55 PM",
                                         "RIVER_CURRENT_LEVEL":"3.19m",
                                         "RIVER_DIFFERENCE":"-0.02m",
                                         "RIVER_PREVIOUS_LEVEL":"3.17m"]
        
        listOfRivers.addObject(exampleData2)
        */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.initLargeTitles()
        
        if(Libraries().CheckInternetConnection(self) == true)
        {
            let qualityOfServiceClass = DispatchQoS.QoSClass.background

            if (listOfRivers?.count)! <= 0 {
                
                self.isFirstLoad = true
                self.loadingSpinner.setLoadingScreen()
                
                DispatchQueue.global(qos: qualityOfServiceClass).async(execute: {
                    self.GetOverallWaterLevelData(dataAmount: self.listTotalAmount)
                })
            }
        } else {
            
            let errorData = ["ERR_CODE":"NO_INTERNET_CONNECTION"]
            listOfRivers = [errorData]
        }
    }
    
    func refreshed(_ sender: UIRefreshControl) {
        
        if(Libraries().CheckInternetConnection(self) == true)
        {
            
            GetOverallWaterLevelData(dataAmount: listTotalAmount)
        } else {
            
            let errorData = ["ERR_CODE":"NO_INTERNET_CONNECTION"]
            listOfRivers = [errorData]
        }
    }
    
    func GetOverallWaterLevelData(dataAmount amount: String)
    {
        listOfRivers!.removeAllObjects()
        allRiverData.removeAllObjects()
        receivedListofRivers.removeAllObjects()
        
        print("[WebServices] Getting Overall Water Level Data Feed")
        
        let getLoginURL = URL.init(string: URLs.kSAIFON_WATER_LEVEL_DATA_URL(amount))
        
        print("[WebServices] Requesting GetOverallWaterLevelData...")
        
        let requestData = NSMutableURLRequest.init(url: getLoginURL!, cachePolicy:NSURLRequest.CachePolicy.useProtocolCachePolicy , timeoutInterval: 60.0)
        requestData.httpMethod = "GET"
        requestData.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        print("[WebServices] Initiating GetOverallWaterLevelData...")
        
        let task = URLSession.shared.dataTask(with: requestData as URLRequest) { (retrievedData,response ,error) -> Void in
            
            print("[Webservices] Got data: \(retrievedData)")
            
            do {
                
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
                
                if let getDataFromJSON = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSMutableArray {
                    
                    DispatchQueue.global(qos: .default).async {
                        
                        self.allRiverData = getDataFromJSON
                        self.waterLevelData()
                    }
                }
            }
            catch let error as NSError {
                
                Alert().showAlert(self, title: "Amaran!", message: "RALAT: Tidak boleh mendapat kan data")
                print("[WebServices] Error while retrieve login data ",error)
            }
        }
        
        task.resume()
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

    func waterLevelData()
    {
        print("[RiverListController] Perform listdata")
        
        var riverName: String = "N/A"
        var riverCurrentReportDate: String = "2222-12-31 00:00:00"
        var riverCurrentReportWaterLevel: String = "0.0"
        var riverWaterLevelDifference: String = "0.0"
        var riverPrevReportWaterLevel: String = "0.0"
        var riverCautionWaterLevel: String? = "0.0"
        var riverWarningWaterLevel: String? = "0.0"
        var riverDangerWaterLevel: String? = "0.0"
        
        for iARD in 0...allRiverData.count - 1
        {
            //Caution, danger, depth, latitude, longitude
            
            let readReceiveData: NSMutableArray = (allRiverData[iARD] as AnyObject).value(forKey: "receives") as! NSMutableArray
            let isSensorActivated = (allRiverData[iARD] as AnyObject).value(forKey: "is_active") as! String
            let isMaintenance = (allRiverData[iARD] as AnyObject).value(forKey: "is_maintenance") as! String
            riverName = (allRiverData[iARD] as AnyObject).value(forKey: "location") as! String
            riverCurrentReportDate = (readReceiveData[0] as AnyObject).value(forKey: "date_receive") as! String
            
            
            if let currentReportWaterLevel = (readReceiveData[0] as AnyObject).value(forKey: "water_depth") as? String {
                riverCurrentReportWaterLevel = currentReportWaterLevel
            }
            
            riverWaterLevelDifference = (readReceiveData[0] as AnyObject).value(forKey: "interval_different") as! String
            
            if let previousReportWaterLevel = (readReceiveData[0] as AnyObject).value(forKey: "interval_depth") as? String {
                riverPrevReportWaterLevel = previousReportWaterLevel
            }
            
            print("[RiverListController] RiverInfo: \((allRiverData[0] as AnyObject).value(forKey: "location") as! String)")
            riverCautionWaterLevel = ((readReceiveData[0] as AnyObject).value(forKey: "location")! as AnyObject).value(forKey: "caution") as? String
            riverWarningWaterLevel = ((readReceiveData[0] as AnyObject).value(forKey: "location")! as AnyObject).value(forKey: "warning") as? String
            riverDangerWaterLevel = ((readReceiveData[0] as AnyObject).value(forKey: "location")! as AnyObject).value(forKey: "danger") as? String
            
            let riverInfo: NSDictionary = ["RIVER_STATUS":WaterLevelLibrary.waterLevelStatus(currentLevel: String(riverCurrentReportWaterLevel), caution: riverCautionWaterLevel!, warning: riverWarningWaterLevel!, danger: riverDangerWaterLevel!),
                                           "RIVER_NAME":riverName,
                                           "RIVER_REPORT_DATE":Libraries.dateFormatConverter(riverCurrentReportDate),
                                           "RIVER_CURRENT_LEVEL":"\(riverCurrentReportWaterLevel)m",
                "RIVER_DIFFERENCE":Libraries.waterLevelConvert(riverWaterLevelDifference),
                "RIVER_PREVIOUS_LEVEL":"\(riverPrevReportWaterLevel)m",
                "ERR_CODE":"OKAY",
                "IS_ACTIVE": "\(isSensorActivated)",
                "IS_MAINTENANCE": isMaintenance]
            
            listOfRivers!.add(riverInfo)
            receivedListofRivers.add(readReceiveData)
        }
        
        if (refreshControl?.isRefreshing)! {
            
            refreshControl?.endRefreshing()
        }
        
        DispatchQueue.main.async {
            
            if self.isFirstLoad {
                self.isFirstLoad = false
                self.loadingSpinner.removeLoadingScreen()
            }
            
            self.tableView.reloadData()
            self.tabBarController?.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    func testTrigger()
    {
        print("[RiverListController] Test triggered")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ _tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let countArrays = ((listOfRivers?.count) != nil) ? listOfRivers?.count : 0
        
        if(countArrays == 0)
        {
            return 1
        }
        else
        {
            return countArrays!
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cellLoading: RLCLoadingTVCell = tableView.dequeueReusableCellWithIdentifier("LoadingWLevelReuseIdentifier") as! RLCLoadingTVCell
        
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        let countArrays = ((listOfRivers?.count) != nil) ? listOfRivers?.count : 0
        
        
        if(countArrays != 0)
        {
            let connectionStatus = (listOfRivers![indexPath.row] as AnyObject).value(forKey: "ERR_CODE") as! String
            
            if connectionStatus == "OKAY" {
                
                let tempData = listOfRivers?.object(at: indexPath.row) as! NSDictionary
                
                if (tempData["IS_ACTIVE"] as! String ) == "1" && (tempData["IS_MAINTENANCE"] as! String ) == "2" {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "RiverDetailedTwoCellID") as! RLCRiverDetailsTVCell
                    
                    cell.updateCell(listOfRivers?.object(at: indexPath.row) as!
                        NSDictionary)
                    tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
                    
                    return cell
                } else {
                    
                    let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceholderCell", for: indexPath) as! PlaceHolderCell
                    
                    cell.updateUI(withName: tempData["RIVER_NAME"] as! String)
                    
                    return cell
                }
            } else if connectionStatus == "NO_INTERNET_CONNECTION" {
                
                let cellError = tableView.dequeueReusableCell(withIdentifier: "ErrorLoadingRiverReuseIdentifier") as! RLCErrorTVC
                
                let errorInternet = ["ERR_CODE":"NO_INTERNET_CONNECTION"]
                
                cellError.setErrorInfo(errorInternet as NSDictionary)
                tableView.separatorStyle = UITableViewCellSeparatorStyle.none
                
                return cellError
            } else {
                
            }
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let tempData = listOfRivers?.object(at: indexPath.row) as! NSDictionary
        
        if (tempData["IS_ACTIVE"] as! String ) == "1" && (tempData["IS_MAINTENANCE"] as! String ) == "2" {
            let receivedIdArray: NSArray = receivedListofRivers.value(forKey: "location_id") as! NSArray
            let getID: String = (receivedIdArray[indexPath.row] as AnyObject).object(at: 0) as! String
            
            selectedRiverDetails = listOfRivers![indexPath.row] as! NSDictionary
            receivedID = getID
            
            performSegue(withIdentifier: "RIVER_FULL_DETAILS_SEGUE", sender: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(listOfRivers!.count == 0) {
            return 100
            
        } else {
            
            let tempData = listOfRivers?.object(at: indexPath.row) as! NSDictionary
            
            if (tempData["IS_ACTIVE"] as! String ) == "1" &&  (tempData["IS_MAINTENANCE"] as! String ) == "2"{
                return UITableViewAutomaticDimension
            } else {
                return 140.0
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if(segue.identifier == "RIVER_FULL_DETAILS_SEGUE") {
            
            let listDetailsController: RLCListDetailsDisplayController = segue.destination as! RLCListDetailsDisplayController
            
            let tempArray: NSMutableArray = []
            tempArray.add(selectedRiverDetails)
            tempArray.add(receivedListofRivers)
            tempArray.add(receivedID)
            
            print("Count tempArray: ", tempArray.count)
            
            listDetailsController.detailsOfRiver = tempArray
        }
    }
}













