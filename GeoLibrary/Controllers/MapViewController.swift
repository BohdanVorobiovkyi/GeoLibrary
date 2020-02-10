//
//  MapViewController.swift
//  GeoLibrary
//
//  Created by usr01 on 10.02.2020.
//  Copyright © 2020 bhdn. All rights reserved.
//

import UIKit
import GoogleMaps
import Photos

class MapViewController: UIViewController {
    
    var assets : [AssetInfoModel] = [AssetInfoModel]() {
        didSet {
//            print(assets)
        }
    }
    
    var allPhotos : PHFetchResult<PHAsset>?  {
        didSet {
            guard let allPhotos = allPhotos else { return }
            for asset in allPhotos.objects(at: IndexSet(0...(self.allPhotos!.count - 1))) {
                let photo = AssetInfoModel(asset: asset)
                assets.append(photo)
                if let lat = photo.latitude, let long = photo.longitude {
                    showMarkers(lat: lat, long: long)
                } else {
                    //photo without coordinates
                }
            }
        }
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Map"
        loadPhotos()
    }
    
    override func loadView() {
        //GoogleMapsView
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView

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
    func showMarkers(lat: Double, long: Double) {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
            marker.map = self.view as! GMSMapView
        }
    }
}
