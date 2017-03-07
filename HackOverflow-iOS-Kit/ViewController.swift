//
//  ViewController.swift
//  HackOverflow-iOS-Kit
//
//  Created by Caroline Ho on 3/6/17.
//  Copyright © 2017 HackOverflow. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, MFMailComposeViewControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var eventTextField: UITextField!
    @IBOutlet weak var topicTextField: UITextField!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var signatureTextField: UITextField!
    
    var pickerData: [[String]] = [[String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connect data
        self.picker.delegate = self
        self.picker.dataSource = self
        
        // Input data into pickers
        pickerData = [["Casual", "Business"], ["Coffee", "Keep in touch"]]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Actions
    @IBAction func sendEmail(_ sender: UIButton) {
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        var greeting = ""
        var recap = ""
        var request = ""
        var closing = ""
        
        if (picker.selectedRow(inComponent: 0) == 0) {
            greeting = "Hi " + contactTextField.text! + ",\n\n"
            recap = "It was great to meet you at " + eventTextField.text! +
                "! I really enjoyed talking with you about " + topicTextField.text! + ". "
            if (picker.selectedRow(inComponent: 1) == 0) {
                request = "Let me know if you're ever free to grab coffee!\n\n"
            } else {
                request = "Let's keep in touch!\n\n"
            }
            closing = "Best,\n" + signatureTextField.text!
        } else {
            greeting = "Dear " + contactTextField.text! + ",\n\n"
            recap = "It was a pleasure to meet you at " + eventTextField.text! +
                " – I really enjoyed talking with you about " + topicTextField.text! + ". "
            if (picker.selectedRow(inComponent: 1) == 0) {
                request = "If you have time in the coming weeks, I would love to take you to coffee to talk further.\n\n"
            } else {
                request = "I hope to keep in touch.\n\n"
            }
            closing = "Many thanks,\n" + signatureTextField.text!
        }
        
        let message = greeting + recap + request + closing
        
        // Configure the fields of the interface.
        composeVC.setToRecipients([emailTextField.text!])
        composeVC.setSubject("Following up from " + eventTextField.text!)
        composeVC.setMessageBody(message, isHTML: false)
        
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    //MARK: Data Sources
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //MARK: Delegates
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }


}

