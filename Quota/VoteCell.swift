//
//  SubmissionViewController.swift
//  Quota
//
//  Created by nasdas on 03.05.16.
//  Copyright © 2016 nasdas. All rights reserved.
//

import UIKit
import CloudKit

class VoteCell: UICollectionViewCell{
   
    
    
    @IBOutlet weak var progressView: UIProgressView!
    
    
    @IBOutlet var cellLabel: UIButton!

//    @IBAction func touchedOption(sender: UIButton) {
//   
//
//        let cell = sender.superview
//        
//        let indexPath =
//        
//        NSString *title = self.strings[indexPath.row];
//        
//        self.someLabel.text = title;
//        
//        print("Touched Cell")
//        
//        
//        
//        
//    }
//    
    
    func updateVoteCount(_ indexPath: IndexPath, pollVotes: [Int]) {

        let totalAmountOfVotes = PolarViewController().addAllVotes(pollVotes)
        
        progressView.progress = Float((pollVotes[(indexPath.row)]))/Float(totalAmountOfVotes) //MAGIC
        

    }
    
    
    

    func nameVoteOptions(_ name: String){
     
        cellLabel.setTitle(name, for: UIControlState())
    
    }
    

}
