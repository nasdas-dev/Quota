//
//  SubmissionViewController.swift
//  Polar
//
//  Created by nasdas on 04.05.16.
//  Copyright © 2016 nasdas. All rights reserved.
//

import UIKit
import CloudKit


protocol setCategoryDelegate{
    func userSetCategory(_ category: String)
}


class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var pickerDelegate: setCategoryDelegate!
    
    @IBOutlet weak var setCategoryLabel: UILabel!
    @IBOutlet weak var catPicker: UIPickerView!
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        let information = catPicker.selectedRow(inComponent: 0)
        print(catPickerData[information])
        pickerDelegate.userSetCategory(catPickerData[information] )
        self.navigationController?.popViewController(animated: true)

    }
    
    var catPickerData = [""]
    var PolarView = PolarViewController()
    
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    func categoriesDefine(){
        
        self.catPicker.delegate = self
        self.catPicker.dataSource = self
        
        
    }
    // - MARK: UIPickerView
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return catPickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return catPickerData[row]
    }
    
    // Catpure the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
    }
    
    

}
