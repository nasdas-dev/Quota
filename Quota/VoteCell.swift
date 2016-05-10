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
   
    
    
    
    
    @IBOutlet var cellLabel: UIButton!

    @IBAction func touchedOption(sender: UIButton) {
   
        let pollRecord = CKRecordID(recordName: "868A3B09-B843-4890-BF0E-FEA68DCDE9A2")
        
        
        
        
    }
    
    
    
    
    

    func nameVoteOptions(name: String){
     
        cellLabel.setTitle(name, forState: .Normal)
    
    }
    

}
