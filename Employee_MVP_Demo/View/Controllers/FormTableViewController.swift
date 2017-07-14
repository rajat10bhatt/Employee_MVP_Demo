//
//  FormTableViewController.swift
//  Employee_MVP_Demo
//
//  Created by Rajat Bhatt on 13/07/17.
//  Copyright © 2017 Rajat Bhatt. All rights reserved.
//

import UIKit
import GooglePlaces

class FormTableViewController: UIViewController {

    @IBOutlet weak var formTableView: UITableView!
    @IBOutlet weak var profileImage: UIImageView!
    
    var fromAddButton = false
    var favourite = false
    var formData: [Int:String] = [:]
    enum formFields: Int {
        case FirstName = 0
        case LastName
        case PhoneNo
        case Designation
        case Address
    }
    let coredataMethods = CoreDataAccessMethods()
    var selectedEmployee: Employee?
    let locationManager = CLLocationManager()
    var placesClient: GMSPlacesClient!
    var latitude = 0.0
    var longitude = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        placesClient = GMSPlacesClient.shared()
        if let employee = selectedEmployee {
            formData[formFields.FirstName.rawValue] = employee.firstName
            formData[formFields.LastName.rawValue] = employee.lastName
            formData[formFields.Address.rawValue] = employee.address
            formData[formFields.Designation.rawValue] = employee.designation
            formData[formFields.PhoneNo.rawValue] = employee.phoneNo
            self.favourite = employee.isFavourite
            self.latitude = employee.latitude
            self.longitude = employee.longitude
        }
        self.profileImage.layer.cornerRadius = profileImage.layer.frame.width/2
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
    
    @IBAction func saveTapped(_ sender: UIButton) {
        print("saveTapped")
        if let employee = selectedEmployee {
            coredataMethods.deleteWithoutCompletion(oldEmployee: employee)
        }
        coredataMethods.saveEmployee(formdata: self.formData, photo: self.profileImage.image!, favourite: self.favourite, latitude: self.latitude, longitude: self.longitude)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func photoTapped(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Error", message: "Camera not available.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Library", style: .default, handler: { (action) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! MapViewController
        destination.latitude = self.latitude
        destination.longitude = self.longitude
    }
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
            if let employee = self.selectedEmployee {
                cell.textView.text = employee.address
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            if indexPath.row == formFields.Address.rawValue {
                return 200
            }
            return 80
        }
        if indexPath.row == formFields.Address.rawValue {
            return 150
        }
        return 50
    }
    
    func setupCell(placeholder: String, tag: Int) -> TextFieldTableViewCell {
        let cell = formTableView.dequeueReusableCell(withIdentifier: "textFieldCell") as! TextFieldTableViewCell
        cell.getTextFieldDataDelegate = self as GetTextFieldDataDelegate
        cell.textField.placeholder = placeholder
        if let employee = self.selectedEmployee {
            switch tag {
            case formFields.FirstName.rawValue: cell.textField.text = employee.firstName
            case formFields.LastName.rawValue: cell.textField.text = employee.lastName
            case formFields.PhoneNo.rawValue: cell.textField.text = employee.phoneNo
            case formFields.Designation.rawValue: cell.textField.text = employee.designation
            default: print("default")
            }
        }
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
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
}

extension FormTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.profileImage.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension FormTableViewController: GMSAutocompleteViewControllerDelegate {
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        self.latitude = place.coordinate.latitude
        self.longitude = place.coordinate.longitude
        
        if let address = place.formattedAddress {
            let cell = self.formTableView.cellForRow(at: IndexPath(row: 4, section: 0)) as! TextViewTableViewCell
            cell.textView.text = "\(place.name)\n\(address)"
            self.formData[formFields.Address.rawValue] = "\(place.name)\n\(address)"
        }
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
