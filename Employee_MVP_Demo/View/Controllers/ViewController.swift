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
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.itemWith(colorfulImage: #imageLiteral(resourceName: "Plus"), target: self, action: #selector(addButtonTapped(_:)))
    }
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "toFormViewController", sender: "addNew")
    }
    
     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addnew = sender as? String {
            if addnew == "addNew" {
                let destination = segue.destination as! FormTableViewController
                destination.fromAddButton = true
            } else {
                let destination = segue.destination as! FormTableViewController
                destination.fromAddButton = false
            }
        }
     }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = employeeTableVIew.dequeueReusableCell(withIdentifier: "employeeCell") as! EmployeeTableViewCell
        cell.nameLabel.text = "Rajat Bhatt"
        cell.profileImage.image = #imageLiteral(resourceName: "Person")
        cell.favouriteButton.tag = indexPath.row
        cell.favouriteClicked = self as FavouriteClicked
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toFormViewController", sender: "oldEmployee")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension ViewController: FavouriteClicked {
    func employeeFavouriteClicked(tag: Int) {
        print(tag)
    }
}
