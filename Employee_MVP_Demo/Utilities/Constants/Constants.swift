//
//  Constants.swift
//  Employee_MVP_Demo
//
//  Created by Rajat Bhatt on 17/07/17.
//  Copyright © 2017 Rajat Bhatt. All rights reserved.
//

import Foundation

enum formFields: Int {
    case FirstName = 0
    case LastName
    case PhoneNo
    case Designation
    case Address
}

struct Constants {
    static let formViewControllerSegue = "toFormViewController"
    static let employeeCellIdentifier = "employeeCell"
    static let mapViewSegue = "toMapView"
}
