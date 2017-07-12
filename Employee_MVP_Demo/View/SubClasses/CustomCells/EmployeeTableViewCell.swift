//
//  EmployeeTableViewCell.swift
//  Employee_MVP_Demo
//
//  Created by Rajat Bhatt on 12/07/17.
//  Copyright © 2017 Rajat Bhatt. All rights reserved.
//

import UIKit

protocol favouriteClicked {
    func employeeFavouriteClicked(tag: Int)
}

class EmployeeTableViewCell: UITableViewCell {
    //MARK: Outlet
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    //MARK: Awake From nib
    override func awakeFromNib() {
        super.awakeFromNib()
        // make image border round
        profileImage.layer.borderWidth = 1.0
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
    }
    
    //MARK: Favourite Button Clicked
    @IBAction func FavouriteClicked(_ sender: UIButton) {
    }
}
