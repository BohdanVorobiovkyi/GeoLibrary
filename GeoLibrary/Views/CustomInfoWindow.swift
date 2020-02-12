//
//  CustomInfoWindow.swift
//  CustomInfoWindow
//
//  Created by Malek T. on 12/13/15.
//  Copyright © 2015 Medigarage Studios LTD. All rights reserved.
//

import UIKit

class CustomInfoWindow: UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        set { layer.cornerRadius = newValue
            clipsToBounds = true
        }
        get { return layer.cornerRadius     }
    }
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
}
