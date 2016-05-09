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

class QuotaViewController: UICollectionViewController{
    
    
    var polls = [CKRecord]()
    var refresh: UIRefreshControl!
    let publicData = CKContainer.defaultContainer().publicCloudDatabase
    var performRefresh = 0
    var tableViewIndex = NSIndexPath(forItem: 0, inSection: 0)
    var cellIndex = 0
    
    // MARK: Voting/Poll Options
    var question = "nil"
    
    // MARK: IBOUTLETS
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.collectionView!.separatorStyle = .None

        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string:"Pull to refresh")
        refresh.addTarget(self, action: #selector(QuotaViewController.loadData), forControlEvents: .ValueChanged)
        self.collectionView!.addSubview(refresh)
        
        loadData()
     

        
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        print(polls.count)
        return polls.count

    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let poll = polls[section]
        let votesContent = poll["votes"] as? [String]
        return votesContent!.count
    }
    
    override func collectionView(collectionView: UICollectionView,
                        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! VoteCell
        let poll = polls[indexPath.section]
        let votesContent = poll["votes"] as? [String]
        let pollContent = poll["question"] as? String
        
        let headerCell = QuestionReusableView()

        // This should give you the string that you want.
        let myString = votesContent![indexPath.row]
        
        // Display the string in the label.
        cell.cellLabel.titleLabel?.text = myString
        headerCell.questionLabel?.text = pollContent
        
        print(myString)
        print(pollContent)
        return cell
        

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
                    self.collectionView!.reloadData()
                    self.refresh.endRefreshing()
                    
                })
            }
        }
    }

}

//    
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            let record = polls[indexPath.row]
//            publicData.deleteRecordWithID(record.recordID, completionHandler: ({returnRecord, error in
//                // do error handling
//            }))
//            polls.removeAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        }
//    }
//    
    // MARK: - Table view data source
    

    
//
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCards
//        
//        
//        if polls.count == 0 {
//            return cell
//        }
//        
//        let poll = polls[indexPath.row]
//        if let pollContent = poll["question"] as? String{
//            
//            let dateFormat = NSDateFormatter()
//            dateFormat.dateFormat = "dd/MM/yyyy"
//            let dateString = dateFormat.stringFromDate(poll.creationDate!)
//        
//            cell.titleLabel?.text = pollContent
//            cell.subTitleLabel?.text = String(dateString)
//            cell.collectionView.tag = indexPath.section
//        }
//        return cell
//    }
    
    
    
    
    // MARK: - TableView actions -> PollOptions
