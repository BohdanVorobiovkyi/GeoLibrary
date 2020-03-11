//
//  AssetsViewModel.swift
//  GeoLibrary
//
//  Created by usr01 on 10.03.2020.
//  Copyright © 2020 bhdn. All rights reserved.
//

import Foundation


class AssetsViewModel {
    
     weak var dataSource : GenericDataSource<AssetInfoModel>?
 
    private let photoManager: PhotoManager
    
    init(photoManager: PhotoManager, dataSource : GenericDataSource<AssetInfoModel>?) {
        self.photoManager = photoManager
        self.dataSource = dataSource
    }
    
    func fetchPhotos() {
        photoManager.loadPhotos { (assets) in
            guard let data = assets else {return}
            self.dataSource?.data.value = data
        }
    }
}
