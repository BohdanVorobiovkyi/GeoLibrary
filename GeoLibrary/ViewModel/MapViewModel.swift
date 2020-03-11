//
//  AssetViewModel.swift
//  GeoLibrary
//
//  Created by usr01 on 06.03.2020.
//  Copyright © 2020 bhdn. All rights reserved.
//

import UIKit
import Photos

class AssetViewModel:  Observer {
    
    func onValueChanged(_ assets: [AssetInfoModel]?) {
           print("Notification ----> Value changed")
           self.assets = assets!
       }
    private var assets : [AssetInfoModel] = [AssetInfoModel]()
    var assetModel: AssetInfoModel
    let manager = PhotoManager.shared
    
    
    let longitude: Double?
    let latitude: Double?
    let fileName: String
    let creationDate: String
    let image: UIImage?
    
    init(assets: AssetInfoModel) {
        self.assets = assetModel
        self.fileName = AssetViewModel.getName(asset: assetModel.asset!)
        self.creationDate = AssetViewModel.getDate(asset: assetModel.asset!)
        self.longitude = assetModel.longitude
        self.latitude = assetModel.latitude
        self.image = AssetViewModel.getAssetThumbnail(asset: assetModel.asset!)
    }
    
    func loadPhotoAssets() {
        
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
    
    static func getDate(asset: PHAsset) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        return dateFormatter.string(from: asset.creationDate!)
    }
}
