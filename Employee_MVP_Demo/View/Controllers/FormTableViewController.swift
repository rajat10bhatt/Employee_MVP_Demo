//
//  FormTableViewController.swift
//  Employee_MVP_Demo
//
//  Created by Rajat Bhatt on 13/07/17.
//  Copyright © 2017 Rajat Bhatt. All rights reserved.
//

import UIKit

class FormTableViewController: UIViewController {

    @IBOutlet weak var formTableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    
    var fromAddButton:Bool!
    var formData: [Int:String] = [:]
    enum formFields: Int {
        case FirstName = 0
        case LastName
        case PhoneNo
        case Designation
        case Address
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.roundCornersForAspectFit(radius: (profileImage.frame.size.width/2))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.itemWith(colorfulImage: #imageLiteral(resourceName: "Back"), target: self, action: #selector(backButtonTapped(_:)))
        if !fromAddButton {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem.itemWith(colorfulImage: #imageLiteral(resourceName: "Pin"), target: self, action: #selector(pinButtonTapped(_:)))
        }
    }
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        //self.dismiss(animated: true, completion: nil)
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    @IBAction func pinButtonTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "toMapView", sender: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension FormTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == formFields.FirstName.rawValue {
            let cell = setupCell(placeholder: "First Name", tag: indexPath.row)
            return cell
        } else if indexPath.row == formFields.LastName.rawValue  {
            let cell = setupCell(placeholder: "Last Name", tag: indexPath.row)
            return cell
        }else if indexPath.row == formFields.PhoneNo.rawValue  {
            let cell = setupCell(placeholder: "Phone Number", tag: indexPath.row)
            return cell
        }else if indexPath.row == formFields.Designation.rawValue  {
            let cell = setupCell(placeholder: "Designation", tag: indexPath.row)
            return cell
        } else {
            let cell = formTableView.dequeueReusableCell(withIdentifier: "textViewCell") as! TextViewTableViewCell
            cell.textView.tag = indexPath.row
            cell.getTextViewDataDelegate = self as GetTextViewDataAndSearchTapDelegate
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == formFields.Address.rawValue {
            return 150
        }
        return 50
    }
    
    func setupCell(placeholder: String, tag: Int) -> TextFieldTableViewCell {
        let cell = formTableView.dequeueReusableCell(withIdentifier: "textFieldCell") as! TextFieldTableViewCell
        cell.getTextFieldDataDelegate = self as GetTextFieldDataDelegate
        cell.textField.placeholder = placeholder
        cell.textField.tag = tag
        if formFields.PhoneNo.rawValue == tag {
            cell.textField.keyboardType = .numberPad
        }
        return cell
    }
}

extension FormTableViewController: GetTextFieldDataDelegate {
    func getTextFieldData(tag: Int, data: String) {
        self.formData[tag] = data
    }
}

extension FormTableViewController: GetTextViewDataAndSearchTapDelegate {
    func getTextViewData(tag: Int, data: String) {
        self.formData[tag] = data
    }
    func searchTapped() {
        print("Search tapped")
    }
}
