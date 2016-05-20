//
//  SubmissionTableViewController.swift
//  Quota
//
//  Created by nasdas on 13.05.16.
//  Copyright © 2016 nasdas. All rights reserved.
//

import UIKit

class SubmissionTableViewController: UITableViewController, titleEnteredDelegate, setCategoryDelegate {
    
    //MARK: IBOUTLETS
    
    @IBOutlet weak var titleCell: UITableViewCell!
    
    
    @IBOutlet weak var votingOptionsCell: UITableViewCell!
    
    @IBOutlet weak var categoryCell: UITableViewCell!
    
    @IBOutlet weak var tagsCell: UITableViewCell!
   
    var dataToReceiveFromTitle = "Enter your question."
    var dataToReceiveFromCategory = "Set a category."
    var dataToReceiveFromTags = "Add some tags."

    func userEnteredTitle(title: String) {
            titleCell.detailTextLabel?.text = title
    }
    
    func userSetCategory(category: String){
            categoryCell.detailTextLabel?.text = category
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Init PickerView Data
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        //        titleCell.textLabel?.text = TitleViewController().
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "TitleSegue"{
        
            let titleVC = segue.destinationViewController as! TitleViewController
            titleVC.titleDelegate = self
        
            
        }
        if segue.identifier == "SetCategory"{
            
            let pickerVC = segue.destinationViewController as! PickerViewController
            pickerVC.pickerDelegate = self
            
            
        }
        
    }
    // MARK: - Table view data source

 
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
