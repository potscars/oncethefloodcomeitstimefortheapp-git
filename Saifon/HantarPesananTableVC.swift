//
//  HantarPesananTableVC.swift
//  Saifon
//
//  Created by Mohd Zulhilmi Mohd Zain on 13/07/2016.
//  Copyright © 2016 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class HantarPesananTableVC: UITableViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet var uitvHPTVCSendMsg: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.edgesForExtendedLayout = UIRectEdge()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let optionButton = UIBarButtonItem()
        optionButton.title = "Hantar"
        optionButton.action = #selector(sendMessage(_:))
        appDelegate.navigation?.rightBarButtonItem = optionButton
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.navigation?.rightBarButtonItem = nil
    }
    
    func sendMessage(_ sender: UIBarButtonItem!)
    {
        print("[HPTVC] Hantar button tapped!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        print("[HPKTVC] ShouldChangeTextInRange detected")
        //let maximumSize = CGSizeMake(280, 999);
        //let txtSize = textView.text
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print("[HPKTVC] TextViewDidEndEditing detected")
        textField.resignFirstResponder()
        return true
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 3)
        {
            return 295
        }
        return 55
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellFromIdentifier") as! HPDaripadaTVCell
        
        if(indexPath.row == 1)
        {
            let cellKepada = tableView.dequeueReusableCell(withIdentifier: "CellToIdentifier") as! HPKepadaTVCell
            
            return cellKepada;
        }
        else if(indexPath.row == 2)
        {
            let cellSubjek = tableView.dequeueReusableCell(withIdentifier: "CellSubjectIdentifier") as! HPSubjekTVC
            
            return cellSubjek;
        }
        else if(indexPath.row == 3)
        {
            let cellHuraian = tableView.dequeueReusableCell(withIdentifier: "CellContentIdentifier") as! HPKandunganTVC
            
            return cellHuraian;
        }

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellFromIdentifier") as! HPDaripadaTVCell
        
        print("[HPTVC] ",cell.GetString())
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
