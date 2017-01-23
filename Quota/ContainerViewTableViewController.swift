//
//  ContainerViewTableViewController.swift
//  Quota
//
//  Created by nasdas on 14.05.16.
//  Copyright © 2016 nasdas. All rights reserved.
//

import UIKit



class ContainerViewTableViewController: UITableViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {
    
    @IBAction func addOtherAnswerButton(_ sender: UIButton) {
        addAnswer()
    }
    
    func addAnswer(){
    
        let indexPath = IndexPath(row: votingOptions.count, section: 0)
        votingOptions.append("p3")
        tableView.insertRows(at: [indexPath], with: .automatic)

    
    }
    
    
    var votingOptions = ["p1", "p2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.setEditing(true, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
  
        return votingOptions.count+1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var displayCell:UITableViewCell?
        displayCell = nil
        let addCell = tableView.dequeueReusableCell(withIdentifier: "addOther")

        let addedCell = tableView.dequeueReusableCell(withIdentifier: "existingAnswer")
        if indexPath.row == votingOptions.count{
            displayCell = addCell
        }
        else{
            displayCell = addedCell
        }
        return displayCell!
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == votingOptions.count {
            return false
        }
        else{
            return true
        }

    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == (votingOptions.count){
            return false
        }
        return true
        
    }
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        var actualIndexPath = IndexPath()
        if (proposedDestinationIndexPath.row == votingOptions.count){
            print("1")
            actualIndexPath = sourceIndexPath

        }
        else{
            actualIndexPath = proposedDestinationIndexPath
        }
        
        return actualIndexPath
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == votingOptions.count){
        
            addAnswer()

        }
        print("tapped")
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            votingOptions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to toIndexPath: IndexPath) {

        
    }
    
    
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
