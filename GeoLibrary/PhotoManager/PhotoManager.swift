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

protocol Observer : class {

    func onValueChanged(_ value: [AssetInfoModel]?)
}

protocol PublisherProtocol : class {

    func addObserver(_ observer: Observer)
    func removeObserver(_ observer: Observer)
//    func sendData(assets: Any)
    func notifyObservers(with newValue: [AssetInfoModel]?)
}

class PhotoManager: PublisherProtocol {

    static let shared = PhotoManager()
    private var allPhotos : PHFetchResult<PHAsset>?
    weak var delegate: PassDataDelegate?
    private init() {    }
    
    private lazy var observers = [Observer]()
         
         func addObserver(_ observer: Observer) {
             observers.append(observer)
             print(#function)
         }
         
         func removeObserver(_ observer: Observer) {
             if let index = observers.firstIndex(where: { $0 === observer}) {
                 observers.remove(at: index)
                 print(#function)
             }
             
         }
         
      func notifyObservers(with newValue: [AssetInfoModel]?) {
             if let loadedeAssets = newValue {
                observers.forEach { ($0.onValueChanged(loadedeAssets)) }
             }
         }
   
    
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
                self?.notifyObservers(with: asset)
            case .denied, .restricted, .notDetermined:
                print("Default")
                
                if let _completion = completion {
                    _completion(nil)
                }
            }
        }
    }
    
    deinit {
        observers.removeAll()
    }
    
}
