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
import SCLAlertView


extension QuotaViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
 
    func collectionView(collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    
    
    func collectionView(collectionView: UICollectionView,
                        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! VoteCell

        let poll = polls[indexPath.row]
        let votesContent = poll["votes"] as? [String]
     
        var from0To4 = 0
        
        cell.cellLabel.titleLabel?.text = votesContent![from0To4]
        from0To4+=1

        return cell

        
        
        
//        let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
//        var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]
//        
//        
//        // MARK: - UICollectionViewDataSource protocol
//        
//        // tell the collection view how many cells to make
//        func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//            return self.items.count
//        }
//        
//        // make a cell for each cell index path
//        func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//            
//            // get a reference to our storyboard cell
//            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MyCollectionViewCell
//            
//            // Use the outlet in our custom class to get a reference to the UILabel in the cell
//            cell.myLabel.text = self.items[indexPath.item]
//            cell.backgroundColor = UIColor.yellowColor() // make cell more visible in our example project
//            
//            return cell
//        }
        
        
        
        
        
//
//        if polls.count == 0 {
//            return cell
//        }
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        //let tableCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCards

        let voteBoxDimensionH = CGFloat(60)
        let voteBoxDimensionW = self.view.frame.size.width / 1.3

        return CGSizeMake(voteBoxDimensionW, voteBoxDimensionH)
    }
    
    
    
}

class QuotaViewController: UITableViewController{
    
    
    var polls = [CKRecord]()
    var refresh: UIRefreshControl!
    let publicData = CKContainer.defaultContainer().publicCloudDatabase
    var performRefresh = 0
    
    
    // MARK: Voting/Poll Options
    var question = "nil"
    
    var labels = TableViewCards()
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
  
    
    override func tableView(tableView: UITableView,
                            willDisplayCell cell: UITableViewCell,
                                            forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let tableViewCell = cell as? TableViewCards else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        
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
        
        navigationController?.popToViewController(SubmissionViewController(), animated: true)
        
        
        
        
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    

    
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCards
        
        
        if polls.count == 0 {
            return cell
        }
        
        let poll = polls[indexPath.row]
        if let pollContent = poll["question"] as? String{
            
            let dateFormat = NSDateFormatter()
            dateFormat.dateFormat = "dd/MM/yyyy"
            let dateString = dateFormat.stringFromDate(poll.creationDate!)
        
            cell.titleLabel?.text = pollContent
            cell.subTitleLabel?.text = String(dateString)
            
        }
        return cell
    }
    
    
    
    
    // MARK: - TableView actions -> PollOptions
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let poll = polls[indexPath.row]
        let pollContent = poll["question"] as? String
        
        print("x")
        

        SCLAlertView().showInfo(pollContent!, subTitle: "Voting Options Here")
        
    }
}