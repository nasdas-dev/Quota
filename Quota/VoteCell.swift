//
//  SubmissionViewController.swift
//  Quota
//
//  Created by nasdas on 03.05.16.
//  Copyright © 2016 nasdas. All rights reserved.
//

import UIKit

class VoteCell: UICollectionViewCell{
   
    @IBOutlet weak var cellLabel: UIButton!

    @IBAction func touchedOption(sender: UIButton) {
        
        
    }
    
    

    func nameVoteOptions(name: String){
     
        cellLabel.titleLabel?.text = name
        
    
    }
    

}
