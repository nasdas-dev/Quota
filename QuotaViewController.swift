//
//  QuotaViewController.swift
//  Quota
//
//  Created by nasdas on 25.04.16.
//  Copyright © 2016 nasdas. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class QuotaViewController: UITableViewController{
    
    var brain = QuotaBrain()
    var polls = [CKRecord]()
    var refresh: UIRefreshControl!
    let publicData = CKContainer.defaultContainer().publicCloudDatabase
    var performRefresh = 0
    
    // MARK: IBOUTLETS
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .None
        

        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string:"Pull to refresh")
        refresh.addTarget(self, action: #selector(QuotaViewController.loadData), forControlEvents: .ValueChanged)
        self.tableView.addSubview(refresh)
        
        loadData()
    }
    

    
    func loadData (){
        
        polls = [CKRecord]()
        let publicData = CKContainer.defaultContainer().publicCloudDatabase
        let query = CKQuery(recordType: "poll", predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        publicData.performQuery(query, inZoneWithID: nil) { (results:[CKRecord]?, error:NSError?) in
            if let polls = results {
                
                self.polls = polls
                dispatch_async(dispatch_get_main_queue(), {
                    print("refreshed")
                    self.tableView.reloadData()
                    self.refresh.endRefreshing()
                    
                })
            }
        }
    }



    
    
    @IBAction func SendPoll(sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "New Poll", message: "Enter A Question", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField) in
            textField.placeholder = "Your Question"
        }
        
        
        
        alert.addAction(UIAlertAction(title: "Send", style: .Default, handler: { (action:UIAlertAction) -> Void in
            let textField = alert.textFields!.first!
            if textField.text != ""{
                let newPoll = CKRecord(recordType: "Poll")
                newPoll["content"] = textField.text
                
                self.publicData.saveRecord(newPoll, completionHandler: { (record:CKRecord?, error:NSError?) in
                    if error == nil{
                        dispatch_async(dispatch_get_main_queue(), {
                            
                            self.tableView.beginUpdates()
                            self.polls.insert(newPoll, atIndex: 0)
                            let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Top)
                            self.tableView.endUpdates()
                            
                        })
                    }
                    else{
                        print ("Error")
                    }
                })
            }
            
        }))
        
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    
    //   override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    //       if(editingStyle == UITableViewCellEditingStyle.Delete){
    //            let indexPredicate = NSPredicate(block: <#T##(AnyObject, [String : AnyObject]?) -> Bool#>)
    ////            let deleteQuery = CKQuery(recordType: "Poll", predicate: <#T##NSPredicate#>)
    //             self.polls.removeAtIndex(indexPath.row)
    //             self.publicData.delete(polls)
    //
    //            let deletePoll = CKRecordID(recordName: "Poll")
    //            self.publicData.deleteRecordWithID(deletePoll, completionHandler: { (record: CKRecordID?, error: NSError?) in
    //                if error == nil{}
    //                self.tableView.reloadData()
    //            })
    
    //       }
    //   }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let record = polls[indexPath.row]
            publicData.deleteRecordWithID(record.recordID, completionHandler: ({returnRecord, error in
                // do error handling
            }))
            polls.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return polls.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        if polls.count == 0 {
            return cell
        }
        
        let poll = polls[indexPath.row]
        if let pollContent = poll["content"] as? String{
            
            let dateFormat = NSDateFormatter()
            dateFormat.dateFormat = "MM/dd/yyyy"
            let dateString = dateFormat.stringFromDate(poll.creationDate!)

            cell.textLabel?.text = pollContent
            cell.detailTextLabel?.text = dateString
        }
        return cell
    }
    
    
    
    // MARK: - TableView actions -> PollOptions
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        print("x")
        
    }
}