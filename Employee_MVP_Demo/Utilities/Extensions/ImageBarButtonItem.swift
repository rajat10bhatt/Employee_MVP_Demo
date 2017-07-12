//
//  ImageBarButtonItem.swift
//  Employee_MVP_Demo
//
//  Created by Rajat Bhatt on 12/07/17.
//  Copyright © 2017 Rajat Bhatt. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    class func itemWith(colorfulImage: UIImage?, target: AnyObject, action: Selector) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(colorfulImage, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.addTarget(target, action: action, for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }
}
