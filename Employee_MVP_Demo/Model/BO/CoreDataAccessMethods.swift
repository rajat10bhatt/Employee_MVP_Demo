//
//  CoreDataAccessMethods.swift
//  Employee_MVP_Demo
//
//  Created by Rajat Bhatt on 14/07/17.
//  Copyright © 2017 Rajat Bhatt. All rights reserved.
//

import Foundation
import UIKit

class CoreDataAccessMethods {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func saveEmployee(formdata: [Int:String], photo: UIImage, favourite: Bool, latitude: Double, longitude: Double) {
        let employee = Employee(context: context) // Link Task & Context
        employee.address = formdata[formFields.Address.rawValue]
        employee.designation = formdata[formFields.Designation.rawValue]
        employee.firstName = formdata[formFields.FirstName.rawValue]
        employee.lastName = formdata[formFields.LastName.rawValue]
        employee.isFavourite = favourite
        employee.phoneNo = formdata[formFields.PhoneNo.rawValue]
        let photodata = UIImagePNGRepresentation(photo)
        employee.photo = photodata
        employee.latitude = latitude
        employee.longitude = longitude
        // Save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        print("Employee Saved")
    }
    
    func getEmployees(completion: ([Employee])->()) {
        do {
            let employees = try context.fetch(Employee.fetchRequest())
            print("Fetch Complete")
            completion(employees as! [Employee])
        } catch {
            print("Fetching Failed")
        }
    }
    
    func deleteEmployee(employee: Employee, completion: ([Employee])->()) {
        context.delete(employee)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        do {
            let employees = try context.fetch(Employee.fetchRequest())
            completion(employees as! [Employee])
        } catch {
            print("Fetching Failed")
        }
    }
    
    func deleteWithoutCompletion(oldEmployee: Employee) {
        context.delete(oldEmployee)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
}


