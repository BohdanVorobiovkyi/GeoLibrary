//
//  PhotosManager.swift
//  GeoLibrary
//
//  Created by usr01 on 10.02.2020.
//  Copyright © 2020 bhdn. All rights reserved.
//

import UIKit
import Photos

protocol PassDataDelegate: class {
    func onLoadingCompleted(arrayOfAsset: [AssetInfoModel])
}

class PhotoManager {

    static let shared = PhotoManager()
    private var allPhotos : PHFetchResult<PHAsset>?
    
    private init() {    }
   
    func mapFetchResult(_ fetchResult: PHFetchResult<PHAsset>) -> Array<AssetInfoModel> {
        var result = Array<AssetInfoModel>()
        fetchResult.enumerateObjects { (asset, _, _) in
            let assetInfoModel = AssetInfoModel(asset: asset) 
            result.append(assetInfoModel)
        }
        return result
    }

    func loadPhotos(completion: (([AssetInfoModel]?) -> ())? = nil) {

        PHPhotoLibrary.requestAuthorization { [weak self] (status) in
            guard let strongSelf = self else {return}
            switch status {
            case .authorized:
                print("Good to proceed")
                let fetchOptions = PHFetchOptions()
                fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
                let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                let asset = strongSelf.mapFetchResult(fetchResult)
                
                if let _completion = completion {
                    _completion(asset)
                }
            case .denied, .restricted, .notDetermined:
                print("Default")
                
                if let _completion = completion {
                    _completion(nil)
                }
            }
        }
    }
}
