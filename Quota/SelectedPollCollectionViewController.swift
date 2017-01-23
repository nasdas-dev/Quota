//
//  SelectedPollCollectionViewController.swift
//  Quota
//
//  Created by nasdas on 21.05.16.
//  Copyright © 2016 nasdas. All rights reserved.
//

import UIKit
import CloudKit

private let reuseIdentifier = "Cell"

class SelectedPollCollectionViewController: UICollectionViewController {
    var polls = [CKRecord]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let poll = polls[section]
        let votesContent = poll["votes"] as? [String]
        return 4
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

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
