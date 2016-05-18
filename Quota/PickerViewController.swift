//
//  SubmissionViewController.swift
//  Quota
//
//  Created by nasdas on 04.05.16.
//  Copyright © 2016 nasdas. All rights reserved.
//

import UIKit
import CloudKit


class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var setCategoryLabel: UILabel!
    @IBOutlet weak var catPicker: UIPickerView!
    
    
    var catPickerData = []
    var QuotaView = QuotaViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesDefine()
        setCategoryLabel.text = "Set a category"
        
        
        // Init PickerView Data
        catPickerData = ["Politics", "Entertainment", "Sports", "News", "Health", "Education"]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    func categoriesDefine(){
        
        self.catPicker.delegate = self
        self.catPicker.dataSource = self
        
        
    }
    // - MARK: UIPickerView
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return catPickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return catPickerData[row] as? String
    }
    
    // Catpure the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
    }
    
    

}
