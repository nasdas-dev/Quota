//
//  NavtigationViewController.swift
//  Quota
//
//  Created by nasdas on 21.06.16.
//  Copyright © 2016 nasdas. All rights reserved.
//

import UIKit

class NavtigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = navigationBar.bounds
//        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
//        navigationBar.addSubview(blurEffectView)
//        
//        
        self.navigationBar.translucent = true
        self.navigationBar.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.4)
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
