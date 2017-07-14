//
//  EmployeeTableViewCell.swift
//  Employee_MVP_Demo
//
//  Created by Rajat Bhatt on 12/07/17.
//  Copyright © 2017 Rajat Bhatt. All rights reserved.
//

import UIKit

protocol FavouriteClicked {
    func employeeFavouriteClicked(tag: Int, favourite: Bool)
}

class EmployeeTableViewCell: UITableViewCell {
    //MARK: Outlet
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    var favouriteClicked:FavouriteClicked?
    var favourite = false
    
    //MARK: Awake From nib
    override func awakeFromNib() {
        super.awakeFromNib()
        //profileImage.roundCornersForAspectFit(radius: (profileImage.frame.size.width/2))
    }
    
    //MARK: Favourite Button Clicked
    @IBAction func FavouriteClicked(_ sender: UIButton) {
        if sender.imageView?.image == #imageLiteral(resourceName: "FavouriteOn") {
            favourite = false
        } else {
            favourite = true
        }
        self.favouriteClicked?.employeeFavouriteClicked(tag: sender.tag, favourite: favourite)
    }
}
