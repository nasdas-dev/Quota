//
//  ContainerViewTableViewController.swift
//  Quota
//
//  Created by nasdas on 14.05.16.
//  Copyright © 2016 nasdas. All rights reserved.
//

import UIKit



class ContainerViewTableViewController: UITableViewController, UIGestureRecognizerDelegate, UITextFieldDelegate {
    
    @IBAction func addOtherAnswerButton(sender: UIButton) {

        let newString = AddAnotherTableViewCell().addAnswerTextField.text
        votingOptions.append(newString!)
        tableView.beginUpdates()
        print(votingOptions)
        
    }
    
    
    var votingOptions = ["Voting Option 1", "Voting Option 2", "Voting Option 3", "Voting Option 4"]
    var hideCellAllowed: Bool! = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let longpress = UILongPressGestureRecognizer(target: self, action: #selector(ContainerViewTableViewController.longPressGestureRecognized(_:)))
        tableView.addGestureRecognizer(longpress)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func longPressGestureRecognized(gestureRecognizer: UIGestureRecognizer) {
        struct My {
            
            static var cellSnapshot : UIView? = nil
            
        }
        struct Path {
            
            static var initialIndexPath : NSIndexPath? = nil
            
        }
        
        
        
        let longPress = gestureRecognizer as! UILongPressGestureRecognizer
        
        let state = longPress.state
        
        let locationInView = longPress.locationInView(tableView)
        
        let indexPath = tableView.indexPathForRowAtPoint(locationInView)
        
        
        
        
        switch state {
            
            
        case UIGestureRecognizerState.Changed:
            if indexPath != nil{
                var center = My.cellSnapshot!.center
                
                center.y = locationInView.y
                
                My.cellSnapshot!.center = center
                
                if ((indexPath != nil) && (indexPath != Path.initialIndexPath)) {
                    
                    swap(&votingOptions[indexPath!.row], &votingOptions[Path.initialIndexPath!.row])
                    
                    tableView.moveRowAtIndexPath(Path.initialIndexPath!, toIndexPath: indexPath!)
                    
                    Path.initialIndexPath = indexPath
                    
                }
               
            }
            
        case UIGestureRecognizerState.Began:
            
            
            if indexPath != nil && indexPath!.section == 0{
                
                Path.initialIndexPath = indexPath
                
                let cell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!
                
                My.cellSnapshot  = snapshopOfCell(cell)
                
                var center = cell.center
                
                My.cellSnapshot!.center = center
                
                My.cellSnapshot!.alpha = 0.0
                
                tableView.addSubview(My.cellSnapshot!)
                cell.hidden = true
                
                
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    
                    center.y = locationInView.y
                    
                    My.cellSnapshot!.center = center
                    
                    My.cellSnapshot!.transform = CGAffineTransformMakeScale(1.05, 1.05)
                    
                    My.cellSnapshot!.alpha = 0.98
                    
                    cell.alpha = 0.0
                    
                    
                    
                    }, completion: { (finished) -> Void in
                        
                        if finished && self.hideCellAllowed == true {
                            cell.hidden = true
                        }
                        
                })
            }
            
            
            
            
            
        default:
            
            
            hideCellAllowed = false
            if indexPath != nil && indexPath!.section == 0{
                let cell = tableView.cellForRowAtIndexPath(Path.initialIndexPath!) as UITableViewCell!
                
                cell.hidden = false
                
                cell.alpha = 0.0
                
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    
                    My.cellSnapshot!.center = cell.center
                    
                    My.cellSnapshot!.transform = CGAffineTransformIdentity
                    
                    My.cellSnapshot!.alpha = 0.0
                    
                    cell.alpha = 1.0
                    
                    }, completion: { (finished) -> Void in
                        
                        if finished {
                            
                            Path.initialIndexPath = nil
                            
                            My.cellSnapshot!.removeFromSuperview()
                            
                            My.cellSnapshot = nil
                            
                        }
                        
                })
            }}
        
    }
    func snapshopOfCell(inputView: UIView) -> UIView {
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0.0)
        
        inputView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext() as UIImage
        
        UIGraphicsEndImageContext()
        
        let cellSnapshot : UIView = UIImageView(image: image)
        
        cellSnapshot.layer.masksToBounds = false
        
        cellSnapshot.layer.cornerRadius = 10.0
        
        cellSnapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0)
        
        cellSnapshot.layer.shadowRadius = 5.0
        
        cellSnapshot.layer.shadowOpacity = 0.4
        
        return cellSnapshot
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let numberOfRowsAtSection = [votingOptions.count, 1]
        
        return numberOfRowsAtSection[section]
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var displayCell:UITableViewCell?
        displayCell = nil
        let cell = tableView.dequeueReusableCellWithIdentifier("VotingOptionsSubmission")
        
        cell!.textLabel?.text = votingOptions[indexPath.row]
        
        
        
        let cell2 = tableView.dequeueReusableCellWithIdentifier("addOther")
        
        // Configure the cell...
        
        if indexPath.section == 0 {
            displayCell = cell
        }
        if indexPath.section == 1 {
            displayCell = cell2
        }
        
        return displayCell!
    }
    
    
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section != 0{
            return false
        }
        return true
        
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            votingOptions.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
        
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
