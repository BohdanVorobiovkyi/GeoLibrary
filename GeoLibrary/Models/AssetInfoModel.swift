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
        self.image = AssetInfoModel.getAssetThumbnail(asset: asset)
    }
    
    static func getName(asset: PHAsset) -> String {
        let assetResources = PHAssetResource.assetResources(for: asset)
        return assetResources.first!.originalFilename
    }
    
    static func getAssetThumbnail(asset: PHAsset) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            thumbnail = result!
        })
        return thumbnail
    }
    
    static func getDate(asset: PHAsset) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: asset.creationDate!) 
    }
}
