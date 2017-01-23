//
//  PolarViewController.swift
//  Polar
//
//  Created by nasdas on 25.04.16.
//  Copyright © 2016 nasdas. All rights reserved.
//

import Foundation
import UIKit
import CloudKit


class PolarViewController: UICollectionViewController{
    // MARK: IBOUTLETS

    
    @IBAction func touchedVoteCell(_ sender: UIButton) {
        
        let cell = sender.superview?.superview as! VoteCell
        let indexPath = self.collectionView!.indexPath(for: cell)
        
        let poll = polls[indexPath!.section] // Poll Cell -> first question: 1, 2nd: 2, ...
        var pollVotes = poll["votesPoints"] as! [Int]
//        
//        let val = Int((pollVotes?[1])!)
//        print(val)
     
        
        
        func findValueToIncreaseByOne (_ array: [Int]) -> [Int] {
        var modifiedArray = array
        var valueToChange = array[(indexPath?.row)!]
        valueToChange+=1
        modifiedArray[(indexPath?.row)!] = valueToChange
            return modifiedArray
        }
        
        poll["votesPoints"] = findValueToIncreaseByOne(pollVotes) as CKRecordValue?

        
        let modifier = CKModifyRecordsOperation(recordsToSave: [poll], recordIDsToDelete: nil)
        publicData.add(modifier)
        
        
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
    let publicData = CKContainer.default().publicCloudDatabase
    var performRefresh = 0
    var tableViewIndex = IndexPath(item: 0, section: 0)
    var cellIndex = 0
    
    // MARK: Voting/Poll Options
    var question = "nil"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.collectionView!.separatorStyle = .None

        refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string:"Pull to refresh")
        refresh.addTarget(self, action: #selector(PolarViewController.loadData), for: .valueChanged)
        self.collectionView!.addSubview(refresh)
       
        loadData()


        
    }
    
    
    func addAllVotes (_ array: [Int]) -> Int{
        
        var totalValue = 0
        for votes in array{
            
            totalValue += votes
            
        }
        
        
        return totalValue
    }
    
    func updateVoteCount(){
    
        
    
    
    }
    

    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                                                   at indexPath: IndexPath) -> UICollectionReusableView {
        let poll = polls[indexPath.section]
        let pollContent = poll["question"] as? String

        
        
        //1
        switch kind {
        //2
        case UICollectionElementKindSectionHeader:
            //3
            let headerView =
                collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                      withReuseIdentifier: "Question",
                                                                      for: indexPath)
                    as! QuestionReusableView
            headerView.questionLabel.text = pollContent
            return headerView
        
        case UICollectionElementKindSectionFooter:
            let footerView =
                collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                      withReuseIdentifier: "Spacing",
                                                                      for: indexPath)
            return footerView
        default:
            //4
            assert(false, "Unexpected element kind")
        }
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        print(polls.count)
        return polls.count

    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let poll = polls[section]
        let votesContent = poll["votes"] as? [String]
        return votesContent!.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let poll2 = polls[indexPath.section]
        let votesContent = poll2["votes"] as? [String]
        let pollVotes = poll2["votesPoints"] as! [Int]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! VoteCell
      
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
        let publicData = CKContainer.default().publicCloudDatabase
        let query = CKQuery(recordType: "poll", predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        publicData.perform(query, inZoneWith: nil){(results:[CKRecord]?, error:Error?) in
            if let polls = results {
                
                self.polls = polls
                DispatchQueue.main.async(execute: {
                    print("refreshed")
                    self.collectionView!.reloadData()
                    self.refresh.endRefreshing()
                    
                })
            }
        } 
    }
    
    

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
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
