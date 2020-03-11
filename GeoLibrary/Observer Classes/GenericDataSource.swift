//
//  GenericDataSource.swift
//  GeoLibrary
//
//  Created by usr01 on 11.03.2020.
//  Copyright © 2020 bhdn. All rights reserved.
//

import Foundation

class GenericDataSource<T> : NSObject {
    var data: ObservableVariable<[T]> = ObservableVariable([])
}
