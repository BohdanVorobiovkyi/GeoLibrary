//
//  MapViewController.swift
//  GeoLibrary
//
//  Created by usr01 on 10.02.2020.
//  Copyright © 2020 bhdn. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate {
    
    let dataSource = GenericDataSource<AssetInfoModel>()
    
    private let manager = PhotoManager.shared
    private var mapView: GMSMapView?
    
    lazy var viewModel: AssetsViewModel = {
        let viewModel = AssetsViewModel(photoManager: manager, dataSource: dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Map"
        
        dataSource.data.addAndNotify(observer: self) {
            self.showMarkers(assets: self.dataSource.data.value)
            if let firstAsset = self.dataSource.data.value.first {
                self.cameraOnMarker(for: firstAsset)
            }
        }
        self.viewModel.fetchPhotos()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func loadView() {
        //GoogleMapsView
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.mapView?.delegate = self
        view = mapView
        
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print(marker.accessibilityLabel)
        mapView.selectedMarker = marker
        return true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        if mapView.selectedMarker != nil
        {
            mapView.selectedMarker = nil
        }
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let index:Int! = Int(marker.accessibilityLabel!)
        print(index)
        let customInfoWindow = Bundle.main.loadNibNamed("CustomInfoWindow", owner: self, options: nil)![0] as! CustomInfoWindow
        DispatchQueue.main.async { [weak self] in
            customInfoWindow.photoImageView.image = self?.dataSource.data.value[index].image
            customInfoWindow.nameLabel.text = self?.dataSource.data.value[index].fileName
            customInfoWindow.dateLabel.text = self?.dataSource.data.value[index].creationDate
            customInfoWindow.reloadInputViews()
        }
        
        return customInfoWindow
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
    
    private func showMarkers(assets: [AssetInfoModel] ) {
        var accessibilityIndex = 0
        print(assets)
        for asset in assets {
            if let lat = asset.latitude, let long = asset.longitude {
                DispatchQueue.main.async {[weak self] in
                    guard let self = self else {return}
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
                    marker.snippet = "aaaaa"
                    marker.infoWindowAnchor = CGPoint(x: 0.5, y: 0.5)
                    marker.accessibilityLabel = "\(accessibilityIndex)"
                    marker.map = self.view as? GMSMapView
                    accessibilityIndex += 1
                    print(accessibilityIndex)
                }
            } else {
                //photo without coordinates
                print("\(asset.fileName) withot coordinates")
            }
        }
    }
}
