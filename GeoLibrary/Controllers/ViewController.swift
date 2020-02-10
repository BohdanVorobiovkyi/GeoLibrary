//
//  ViewController.swift
//  GeoLibrary
//
//  Created by usr01 on 10.02.2020.
//  Copyright © 2020 bhdn. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController {
    
    @IBOutlet weak var photosDescriptionTable: UITableView!
    
    var assets : [AssetInfoModel] = [AssetInfoModel]() {
        didSet {
            print(assets)
        }
    }
    
    var allPhotos : PHFetchResult<PHAsset>?  {
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
            DispatchQueue.main.async {[weak self] in
                guard let self = self else {return}
                self.photosDescriptionTable.reloadData()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Photos Table"
        photosDescriptionTable.dataSource = self
        photosDescriptionTable.delegate = self
        loadPhotos()
    }
    
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

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "geoCell") as? GeoTableCell else { return UITableViewCell() }
        cell.cellLabel.text = "\(assets[indexPath.row].fileName!)  \(assets[indexPath.row].creationDate!)"
        return cell
        
    }
    
//    func getName(asset: PHAsset) -> String {
//        let assetResources = PHAssetResource.assetResources(for: asset)
//        return assetResources.first!.originalFilename
//    }
//
//    func getDate(asset: PHAsset) -> String? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd/MM/yyyy"
//        return String()
//    }
}

