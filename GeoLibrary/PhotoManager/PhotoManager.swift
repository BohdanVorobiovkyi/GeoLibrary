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
            guard let allPhotos = allPhotos else { return }
            for asset in allPhotos.objects(at: IndexSet(0...(self.allPhotos!.count - 1))) {
                let photo = AssetInfoModel(asset: asset)
                assets.append(photo)
            }
        }
    }
    
    private init() {    }
    
    func loadPhotos(completion: @escaping ([AssetInfoModel]?) -> () ) {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                print("Good to proceed")
                let fetchOptions = PHFetchOptions()
                fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                self.allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                completion(self.assets)
            case .denied, .restricted:
                print("Not allowed")
                completion(nil)
            case .notDetermined:
                print("Not determined yet")
                completion(nil)
            @unknown default:
                print("Default")
                completion(nil)
            }
        }
    }
    
}
