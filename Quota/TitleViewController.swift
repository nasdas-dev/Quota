//
//  TitleAndTagsViewController.swift
//  Quota
//
//  Created by nasdas on 15.05.16.
//  Copyright © 2016 nasdas. All rights reserved.
//

import UIKit
// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

protocol titleEnteredDelegate {
    func userEnteredTitle(title: String)
}

class TitleViewController: UIViewController, UITextViewDelegate {
    var titleDelegate: titleEnteredDelegate!
    

    
    //MARK: IBOUTLETS
    
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        
        
        
    }
    
    
    @IBAction func saveButton(sender: UIBarButtonItem) {
            let information = contentTextView.text
            titleDelegate.userEnteredTitle(information)
            self.navigationController?.popViewControllerAnimated(true)
    
            
        
    }
    
    @IBOutlet weak var characterLimitLabel: UILabel!
    
    @IBOutlet weak var contentTextView: UITextView!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionSetup()
        self.hideKeyboardWhenTappedAround()
        contentTextView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func questionSetup(){
        contentTextView.becomeFirstResponder()
        
        contentTextView.selectedTextRange = contentTextView.textRangeFromPosition(contentTextView.beginningOfDocument, toPosition: contentTextView.beginningOfDocument)

    }

    func textViewDidChange(textView: UITextView) {
        
        var lblNumber = Int(characterLimitLabel.text!)
        
        let lblNumberUpdate = textView.text.characters.count
        
        lblNumber = 100 - lblNumberUpdate
        characterLimitLabel.text = String(lblNumber!)
        
        if (lblNumber <= 20){
            characterLimitLabel.textColor = UIColor.redColor()
        }
        else{
        
            characterLimitLabel.textColor = UIColor.blackColor()
        }
        
        if (lblNumber == 0){
            characterLimitLabel.textColor = UIColor.grayColor()
        }
        
    }
  
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        return textView.text.characters.count + (text.characters.count - range.length) <= 100

    }
    
    func textViewDidChangeSelection(textView: UITextView) {
        if self.view.window != nil {
            if textView.textColor == UIColor.lightGrayColor() {
                textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
            }
        }

    
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
