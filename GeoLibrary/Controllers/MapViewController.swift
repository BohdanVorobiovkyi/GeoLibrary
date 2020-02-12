//
//  MapViewController.swift
//  GeoLibrary
//
//  Created by usr01 on 10.02.2020.
//  Copyright © 2020 bhdn. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, Observer, PassDataDelegate {
    
    func onValueChanged(_ value: Any?) {
        print("Notification ----> Value changed \(value)")
    }

    func onLoadingCompleted(arrayOfAsset : [AssetInfoModel]) {
        self.assets = arrayOfAsset
    }
    
    private let manager = PhotoManager.shared
    private var mapView: GMSMapView?
    private var assets : [AssetInfoModel] = [AssetInfoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Map"
        manager.addObserver(self)
        manager.loadPhotos { (assets) in
            guard let data = assets else {return}
            self.assets = data
            self.showMarkers(asset: data)
            if let asset = data.first {
                self.cameraOnMarker(for: asset)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        manager.delegate = self
//        manager.loadPhotos()
    }
    
    override func loadView() {
        //GoogleMapsView
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
    }
    
    private func cameraOnMarker(for asset: AssetInfoModel) {
           guard let lat = asset.latitude, let long = asset.longitude else {return}
           DispatchQueue.main.async {[weak self] in
               guard let self = self else {return}
               let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 2.0)
               self.mapView?.camera = camera
               self.mapView?.animate(to: camera)
           }
       }
       
       private func showMarkers(asset: Array<AssetInfoModel> ) {
           for asset in assets {
               if let lat = asset.latitude, let long = asset.longitude {
                   DispatchQueue.main.async {[weak self] in
                       guard let self = self else {return}
                       let marker = GMSMarker()
                       marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
                       marker.map = self.view as! GMSMapView
                   }
               } else {
                   //photo without coordinates
               }
           }
       }
}
