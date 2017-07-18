//
//  ViewController.swift
//  Employee_MVP_Demo
//
//  Created by Rajat Bhatt on 12/07/17.
//  Copyright © 2017 Rajat Bhatt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var employeeTableVIew: UITableView!
    
    let coreDatamethods = CoreDataAccessMethods()
    var employeesData: [Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.itemWith(colorfulImage: #imageLiteral(resourceName: "Plus"), target: self, action: #selector(addButtonTapped(_:)))
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchEmployees()
    }
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: Constants.formViewControllerSegue, sender: "addNew")
    }
    
     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.formViewControllerSegue {
            let destination = segue.destination as! FormTableViewController
            if let _ = sender as? String {
                destination.fromAddButton = true
            }
            if let employee = sender as? Employee {
                destination.selectedEmployee = employee
            }
        }
     }
    func fetchEmployees() {
        coreDatamethods.getEmployees { [unowned self] (employees) in
            if employees.count != 0{
                self.employeesData = employees
                DispatchQueue.main.async {
                    self.employeeTableVIew.reloadData()
                }
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.employeesData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = employeeTableVIew.dequeueReusableCell(withIdentifier: Constants.employeeCellIdentifier) as! EmployeeTableViewCell
        cell.nameLabel.text = "\(self.employeesData[indexPath.row].firstName ?? "") \(self.employeesData[indexPath.row].lastName ?? "")"
        cell.profileImage.image = UIImage(data: self.employeesData[indexPath.row].photo!)
        if self.employeesData[indexPath.row].isFavourite {
            cell.favouriteButton.setImage(#imageLiteral(resourceName: "FavouriteOn"), for: .normal)
        } else {
            cell.favouriteButton.setImage(#imageLiteral(resourceName: "FavouriteOff"), for: .normal)
        }
        cell.favouriteButton.tag = indexPath.row
        cell.favouriteClicked = self as FavouriteClicked
        cell.profileImage.layer.cornerRadius = cell.profileImage.frame.height/2
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: Constants.formViewControllerSegue, sender: employeesData[indexPath.row])
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            return 130
        }
        return 70
    }
}

extension ViewController: FavouriteClicked {
    func employeeFavouriteClicked(tag: Int, favourite: Bool) {
        print(tag)
        let employee = employeesData[tag]
        var formData:[Int:String] = [:]
        formData[formFields.FirstName.rawValue] = employee.firstName
        formData[formFields.LastName.rawValue] = employee.lastName
        formData[formFields.PhoneNo.rawValue] = employee.phoneNo
        formData[formFields.Designation.rawValue] = employee.designation
        formData[formFields.Address.rawValue] = employee.address
        let photo = UIImage(data: employee.photo!)
        let latitude = employee.latitude
        let longitude = employee.longitude
        coreDatamethods.deleteWithoutCompletion(oldEmployee: employee)
        coreDatamethods.saveEmployee(formdata: formData, photo: photo!, favourite: favourite, latitude: latitude, longitude: longitude)
        fetchEmployees()
    }
}
