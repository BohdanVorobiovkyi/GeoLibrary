//
//  AssetInfoModel.swift
//  GeoLibrary
//
//  Created by usr01 on 10.02.2020.
//  Copyright © 2020 bhdn. All rights reserved.
//

import UIKit
import Photos

struct AssetInfoModel {

    let fileName: String?
    let longitude: Double?
    let latitude: Double?
    let creationDate: String?
    let image: UIImage?
    
    init(asset: PHAsset) {
        self.fileName = AssetInfoModel.getName(asset: asset)
        self.creationDate = AssetInfoModel.getDate(asset: asset)
        self.longitude = asset.location?.coordinate.longitude
        self.latitude = asset.location?.coordinate.latitude
        self.image = UIImage()
    }
    
       static func getName(asset: PHAsset) -> String {
           let assetResources = PHAssetResource.assetResources(for: asset)
           return assetResources.first!.originalFilename
       }
       
       static func getDate(asset: PHAsset) -> String? {
            let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: asset.creationDate!) 
       }
}
