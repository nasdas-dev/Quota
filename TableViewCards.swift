//
//  TableViewCards.swift
//  Quota
//
//  Created by nasdas on 27.04.16.
//  Copyright © 2016 nasdas. All rights reserved.
//

import Foundation
import UIKit

class TableViewCards: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UITextView!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var borderImage: UIImageView!
    
    
    override func layoutSubviews() {
        cardSetup()
    }
    
    func cardSetup(){
        self.cardView.alpha = 1.0
        self.cardView.layer.masksToBounds = true
        self.cardView.layer.cornerRadius = 5 // if you like rounded corners
        self.cardView.layer.shadowOffset = CGSizeMake(0, -10)//%%% this shadow will hang slightly down and to the right
        self.cardView.layer.shadowRadius = 1 //%%% I prefer thinner, subtler shadows, but you can play with this
        self.cardView.layer.shadowOpacity = 0.2 //%%% same thing with this, subtle is better for me
        
        let path = UIBezierPath(rect: self.cardView.bounds)
        self.cardView.layer.shadowPath = path.CGPath
        
    }
    
}
