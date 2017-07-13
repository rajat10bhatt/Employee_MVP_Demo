//
//  TextViewTableViewCell.swift
//  Employee_MVP_Demo
//
//  Created by Rajat Bhatt on 13/07/17.
//  Copyright © 2017 Rajat Bhatt. All rights reserved.
//

import UIKit

protocol GetTextViewDataAndSearchTapDelegate {
    func getTextViewData(tag: Int, data: String)
    func searchTapped()
}

class TextViewTableViewCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    
    var getTextViewDataDelegate: GetTextViewDataAndSearchTapDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func searchTapped(_ sender: UIButton) {
        getTextViewDataDelegate.searchTapped()
    }
    
}

extension TextViewTableViewCell: UITextViewDelegate {
    // hides text fields
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            if let data = textView.text {
                getTextViewDataDelegate.getTextViewData(tag: textView.tag, data: data)
            }
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
