//
//  GeoTableCell.swift
//  GeoLibrary
//
//  Created by usr01 on 10.02.2020.
//  Copyright © 2020 bhdn. All rights reserved.
//

import UIKit

class GeoTableCell: UITableViewCell {
    
    @IBOutlet weak var cellLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
