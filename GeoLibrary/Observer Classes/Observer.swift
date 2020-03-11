//
//  Observer.swift
//  GeoLibrary
//
//  Created by usr01 on 10.03.2020.
//  Copyright © 2020 bhdn. All rights reserved.
//

import Foundation


protocol Observer {
    var id : Int { get } // property to get an id
    func update<T>(with newValue: T)
}

