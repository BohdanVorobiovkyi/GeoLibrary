//
//  PhotosManager.swift
//  GeoLibrary
//
//  Created by usr01 on 10.02.2020.
//  Copyright © 2020 bhdn. All rights reserved.
//

import UIKit
import Photos

class PhotoManager {
    
    static let shared = PhotoManager()
    var assets : [AssetInfoModel] = [AssetInfoModel]()
    private var allPhotos : PHFetchResult<PHAsset>?  {
        didSet {
            guard let allPhotos = allPhotos else {
                return
            }
            for asset in allPhotos.objects(at: IndexSet(0...(self.allPhotos!.count - 1))) {
                print(asset)
                
                let photo = AssetInfoModel(asset: asset)
                print(photo)
                assets.append(photo)
            }
        }
    }
    
    private init() {  }
    
    private func loadPhotos() {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                print("Good to proceed")
                let fetchOptions = PHFetchOptions()
                fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                self.allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                
            case .denied, .restricted:
                print("Not allowed")
            case .notDetermined:
                print("Not determined yet")
            @unknown default:
                print("Default")
            }
        }
    }
    
}
