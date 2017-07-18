//
//  SampleViewController.swift
//  Employee_MVP_Demo
//
//  Created by Rajat Bhatt on 17/07/17.
//  Copyright © 2017 Rajat Bhatt. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController {
    
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewTextViewOutlet: UIView!
    @IBOutlet weak var textViewHeightConstraintOutlet: NSLayoutConstraint!
    @IBOutlet weak var commentsTextView: UITextView!
    var selectedButton: UIButton?
    var originalTextViewHeight: CGFloat!
    var originalContainerViewHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        originalTextViewHeight = textViewHeightConstraintOutlet.constant
        originalContainerViewHeight = containerViewHeight.constant
        self.containerViewHeight.constant -= originalTextViewHeight
        self.textViewHeightConstraintOutlet.constant = 0.0
    }
    
    @IBAction func radioButtonClicked(_ sender: Any) {
        if let sender = sender as? UIButton {
            print("Tag:- \(sender.tag)")
            if let selectedButton = self.selectedButton {
                selectedButton.setImage(#imageLiteral(resourceName: "EmptyRadio"), for: .normal)
            }
            self.selectedButton = sender
            sender.setImage(#imageLiteral(resourceName: "FilledRadio"), for: .normal)
            if sender.tag == 2 {
                self.textViewHeightConstraintOutlet.constant = originalTextViewHeight
                self.containerViewHeight.constant = originalContainerViewHeight
            } else {
                if selectedButton?.tag == 2 {
                    self.containerViewHeight.constant -= originalTextViewHeight
                    self.textViewHeightConstraintOutlet.constant = 0.0
                }
            }
        }
        print("Radio Clicked")
    }
}
