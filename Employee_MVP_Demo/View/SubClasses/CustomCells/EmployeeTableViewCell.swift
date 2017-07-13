//
//  EmployeeTableViewCell.swift
//  Employee_MVP_Demo
//
//  Created by Rajat Bhatt on 12/07/17.
//  Copyright © 2017 Rajat Bhatt. All rights reserved.
//

import UIKit

protocol FavouriteClicked {
    func employeeFavouriteClicked(tag: Int)
}

class EmployeeTableViewCell: UITableViewCell {
    //MARK: Outlet
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    var favouriteClicked:FavouriteClicked?
    
    //MARK: Awake From nib
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.roundCornersForAspectFit(radius: (profileImage.frame.size.width/2))
    }
    
    //MARK: Favourite Button Clicked
    @IBAction func FavouriteClicked(_ sender: UIButton) {
        self.favouriteClicked?.employeeFavouriteClicked(tag: sender.tag)
    }
}
