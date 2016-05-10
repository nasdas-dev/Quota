//
//  SubmissionViewController.swift
//  Quota
//
//  Created by nasdas on 04.05.16.
//  Copyright © 2016 nasdas. All rights reserved.
//

import UIKit
import CloudKit


class SubmissionViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    @IBOutlet weak var pollTitle: UITextField!
    
    @IBOutlet weak var pOption1: UITextField!
    @IBOutlet weak var pOption2: UITextField!
    @IBOutlet weak var pOption3: UITextField!
    @IBOutlet weak var pOption4: UITextField!
    var votes = []

    @IBOutlet weak var catPicker: UIPickerView!
    
    @IBAction func submitButton(sender: UIButton) {
       
        votes = [pOption1.text!, pOption2.text!, pOption3.text!, pOption4.text!]
        
        if pollTitle.text != ""{
        let newPoll = CKRecord(recordType: "Poll")
       
        newPoll["question"] = pollTitle.text
        newPoll["votes"] = votes
        

        

        QuotaView.publicData.saveRecord(newPoll, completionHandler: { (record:CKRecord?, error:NSError?) in
            if error == nil{
                dispatch_async(dispatch_get_main_queue(), {
                    
                        self.QuotaView.polls.insert(newPoll, atIndex: 0)
                        self.navigationController?.popViewControllerAnimated(true)
                        let refresh = self.QuotaView.refresh
                        self.QuotaView.collectionView!.addSubview(refresh)
                    
                
                    
                })
            }
            else{
                print("Nothing")
            }
        })

        }
}
    
    
        

    var catPickerData = []
    var QuotaView = QuotaViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pollTitle.delegate = self
        pOption1.delegate = self
        pOption2.delegate = self
        pOption3.delegate = self
        pOption4.delegate = self
        categoriesDefine()
        
        
        
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
