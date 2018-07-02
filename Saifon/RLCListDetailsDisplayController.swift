//
//  RLCListDetailsDisplayController.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 11/10/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit
import BEMSimpleLineGraph

class RLCListDetailsDisplayController: UITableViewController {
    
    var detailsOfRiver: NSMutableArray!
    var waterDepthValues = [Double]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableview()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupGraphData()
        let indexPath = IndexPath(row: 1, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func setupTableview() {
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 140.0
        self.edgesForExtendedLayout = UIRectEdge()
        
        self.navigationController?.deinitLargeTitles()
    }
    
    func setupGraphData() {
        //check kalau id sama, simpan water depth untuk id tu.
        //kena loop dua kali, sebab data ada array inception.
        guard let id = detailsOfRiver[2] as? String else { return }

        if let riverLists = detailsOfRiver[1] as? NSArray {
            
            waterDepthValues.removeAll()
            for riverList in riverLists {
                guard let rivers = riverList as? NSArray else { return }
                
                for river in rivers {
                    if let locationID = (river as AnyObject).object(forKey: "location_id") as? String {
                        if locationID == id {
                            
                            guard let waterDepth = (river as AnyObject).object(forKey: "water_depth") as? String else { return }
                            let waterDepthInDouble = Double(waterDepth)
                            waterDepthValues.append(waterDepthInDouble!.rounded(toPlaces: 2))
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ _tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row == 1)
        {
            let graphCell = tableView.dequeueReusableCell(withIdentifier: RiverIdentifier.RiverLevelGraphCellIdentifier, for: indexPath) as! RiverLevelGraphCell
            
            graphCell.updateGraphUI(waterDepthValues: waterDepthValues)
            
            return graphCell
        }
        else {
            let cell: RLCRiverDetailsTVCell = tableView.dequeueReusableCell(withIdentifier: "RiverDetailedTwoCellID") as! RLCRiverDetailsTVCell
            
            cell.updateCell(detailsOfRiver[0] as! NSDictionary)
            return cell
        }

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 1 {
            return 300
        }
        
        return UITableViewAutomaticDimension
    }
}







