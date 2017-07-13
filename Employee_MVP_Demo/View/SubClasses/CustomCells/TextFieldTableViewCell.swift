//
//  TextFieldTableViewCell.swift
//  Employee_MVP_Demo
//
//  Created by Rajat Bhatt on 13/07/17.
//  Copyright © 2017 Rajat Bhatt. All rights reserved.
//

import UIKit

protocol GetTextFieldDataDelegate {
    func getTextFieldData(tag: Int, data: String)
}

class TextFieldTableViewCell: UITableViewCell {
    @IBOutlet weak var textField: UITextField!
    
    var getTextFieldDataDelegate: GetTextFieldDataDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension TextFieldTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(textField.text ?? "Hello")
        print(textField.tag)
        if let data = textField.text {
            self.getTextFieldDataDelegate?.getTextFieldData(tag: textField.tag, data: data)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text ?? "Hello")
        print(textField.tag)
        textField.resignFirstResponder()
        return true
    }
}
