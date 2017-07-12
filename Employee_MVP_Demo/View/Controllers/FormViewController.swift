//
//  FormViewController.swift
//  Employee_MVP_Demo
//
//  Created by Rajat Bhatt on 12/07/17.
//  Copyright © 2017 Rajat Bhatt. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var firstNameTxtFld: UITextField!
    @IBOutlet weak var lastNameTxtFld: UITextField!
    @IBOutlet weak var phoneNoTxtFld: UITextField!
    @IBOutlet weak var designationTxtFld: UITextField!
    @IBOutlet weak var addressTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.borderWidth = 1.0
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.itemWith(colorfulImage: #imageLiteral(resourceName: "Back"), target: self, action: #selector(backButtonTapped(_:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.itemWith(colorfulImage: #imageLiteral(resourceName: "Pin"), target: self, action: #selector(pinButtonTapped(_:)))
        
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
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
