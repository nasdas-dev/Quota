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


class QuotaViewController: UICollectionViewController{
    // MARK: IBOUTLETS

    
    @IBAction func touchedVoteCell(sender: UIButton) {
        
        let cell = sender.superview?.superview as! VoteCell
        let indexPath = self.collectionView!.indexPathForCell(cell)
        
        let poll = polls[indexPath!.section] // Poll Cell -> first question: 1, 2nd: 2, ...
        var pollVotes = poll["votesPoints"] as! [Int]
//        
//        let val = Int((pollVotes?[1])!)
//        print(val)
     
        
        
        func findValueToIncreaseByOne (array: [Int]) -> [Int] {
        var modifiedArray = array
        var valueToChange = array[(indexPath?.row)!]
        valueToChange+=1
        modifiedArray[(indexPath?.row)!] = valueToChange
            return modifiedArray
        }
        
        poll["votesPoints"] = findValueToIncreaseByOne(pollVotes)

        
        let modifier = CKModifyRecordsOperation(recordsToSave: [poll], recordIDsToDelete: nil)
        publicData.addOperation(modifier)
        
        
//        operation.queryCompletionBlock = { cursor, error in
//            self.tableView.ReloadData()
//        }
//        publicDatabase.addOperation(operation)
//    }
//    
//    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
//        var record = self.booksIncludedInVote[indexPath.row]
//        // now increment the voteCount value in that record and save it using
//        publicDatabase.saveRecord(theRecord, completionHandler
//    }

        
        //Cell Appearance
        
        cell.updateVoteCount(indexPath!, pollVotes: pollVotes)
        collectionView?.reloadData()
//        VoteCell().reloadInputViews()
//
//
//        let totalAmountOfVotes = addAllVotes(pollVotes)
//        cell.progressView.progress = Float((pollVotes[(indexPath?.row)!]))/Float(totalAmountOfVotes) //MAGIC
//        
        
    }
    
    
    var polls = [CKRecord]()
    var refresh: UIRefreshControl!
    let publicData = CKContainer.defaultContainer().publicCloudDatabase
    var performRefresh = 0
    var tableViewIndex = NSIndexPath(forItem: 0, inSection: 0)
    var cellIndex = 0
    
    // MARK: Voting/Poll Options
    var question = "nil"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.collectionView!.separatorStyle = .None

        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string:"Pull to refresh")
        refresh.addTarget(self, action: #selector(QuotaViewController.loadData), forControlEvents: .ValueChanged)
        self.collectionView!.addSubview(refresh)
       
        loadData()


        
    }
    
    
    func addAllVotes (array: [Int]) -> Int{
        
        var totalValue = 0
        for votes in array{
            
            totalValue += votes
            
        }
        
        
        return totalValue
    }
    
    func updateVoteCount(){
    
        
    
    
    }
    

    override func collectionView(collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                                                   atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let poll = polls[indexPath.section]
        let pollContent = poll["question"] as? String

        
        
        //1
        switch kind {
        //2
        case UICollectionElementKindSectionHeader:
            //3
            let headerView =
                collectionView.dequeueReusableSupplementaryViewOfKind(kind,
                                                                      withReuseIdentifier: "Question",
                                                                      forIndexPath: indexPath)
                    as! QuestionReusableView
            headerView.questionLabel.text = pollContent
            return headerView
        
        case UICollectionElementKindSectionFooter:
            let footerView =
                collectionView.dequeueReusableSupplementaryViewOfKind(kind,
                                                                      withReuseIdentifier: "Spacing",
                                                                      forIndexPath: indexPath)
            return footerView
        default:
            //4
            assert(false, "Unexpected element kind")
        }
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
                        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let poll2 = polls[indexPath.section]
        let votesContent = poll2["votes"] as? [String]
        let pollVotes = poll2["votesPoints"] as! [Int]
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! VoteCell
      
        cell.layer.cornerRadius = 16.0
        
        
        // This should give you the string that you want.
        let myString = votesContent![indexPath.item]
        
        
        // Display the string in the label
        cell.nameVoteOptions(myString)

        
        cell.updateVoteCount(indexPath, pollVotes: pollVotes)
        
        //
//        let totalAmountOfVotes = addAllVotes(pollVotes)
//        cell.progressView.progress = Float((pollVotes[(indexPath.row)]))/Float(totalAmountOfVotes) //MAGIC
//        
        
        print(myString)
    
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
    
    

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath)
        print("selected cell: \(cell)")
    
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
