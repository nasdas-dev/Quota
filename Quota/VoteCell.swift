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

        
        //Gradient color
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.frame
        
        gradientLayer.anchorPoint = CGPoint(x: 0, y: 0)
        gradientLayer.position = CGPoint(x: 0, y: 0)
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0);
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0);
        
        gradientLayer.colors = [
            UIColor.red,
            UIColor.green
        ]
        
        
        
        // Convert to UIImage
        progressView.layer.insertSublayer(gradientLayer, at: 0)
        progressView.progressTintColor = UIColor.clear
        progressView.trackTintColor = UIColor.black


    }
    
    
    

    func nameVoteOptions(_ name: String){
     
        cellLabel.setTitle(name, for: UIControlState())
    
    }
    

}
