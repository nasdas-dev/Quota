//
//  SpacingSettings.swift
//  Quota
//
//  Created by nasdas on 21.05.16.
//  Copyright © 2016 nasdas. All rights reserved.
//

import UIKit

class SpacingSettings: UICollectionReusableView {
    
    @IBOutlet weak var spacing: UIView! {
    
        didSet{
            spacing.layer.shadowColor = UIColor.blackColor().CGColor
            spacing.layer.shadowPath = UIBezierPath(rect: spacing.bounds).CGPath
            spacing.layer.shadowOpacity = 1
            spacing.layer.shadowRadius = 4.0
            spacing.clipsToBounds = false
            spacing.layer.masksToBounds = false
        }
    
    }
    

  
}
