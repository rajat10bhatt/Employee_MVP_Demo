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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = employeeTableVIew.dequeueReusableCell(withIdentifier: "employeeCell") as! EmployeeTableViewCell
        cell.nameLabel.text = "Rajat Bhatt"
        cell.profileImage.image = #imageLiteral(resourceName: "Person")
        cell.favouriteButton.tag = indexPath.row
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toFormViewController", sender: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

