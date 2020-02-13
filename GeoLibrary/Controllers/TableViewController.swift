//
//  ViewController.swift
//  GeoLibrary
//
//  Created by usr01 on 10.02.2020.
//  Copyright © 2020 bhdn. All rights reserved.
//

import UIKit
import Photos

class TableViewController: UIViewController, Observer {
    
    @IBOutlet weak var photosDescriptionTable: UITableView!
    
    private let manager = PhotoManager.shared
    
    private var assets : [AssetInfoModel] = [AssetInfoModel]() {
        didSet {
            DispatchQueue.main.async {[weak self] in
                self?.photosDescriptionTable.reloadData()
            }
        }
    }
    
    var coordinateInfoModel: CageInfoModel = CageInfoModel()  {
        didSet {
            let country: String = coordinateInfoModel.results[0].components.country
            let continent: String = coordinateInfoModel.results[0].components.continent
            DispatchQueue.main.async {
                self.showAlert(title: continent, message: country)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.addObserver(self)
        self.title = "Photos Table"
        photosDescriptionTable.dataSource = self
        photosDescriptionTable.delegate = self
        photosDescriptionTable.tableFooterView = UIView()
        manager.loadPhotos()
    }
    
    // MARK: Observer protocol method
    func onValueChanged(_ value: [AssetInfoModel]?) {
        if let _value = value {
            self.assets = _value
        }
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "geoCell") as? GeoTableCell else { return UITableViewCell() }
        cell.cellLabel.text = "\(assets[indexPath.row].fileName!)  \(assets[indexPath.row].creationDate!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let asset = assets[indexPath.row]
        guard let lat = asset.latitude, let long = asset.longitude else {
            showAlert(title: "Photo doesn't have coordinates", message: "Try another one")
            return
        }
        
        NetworkService.reverseGeocoding(latitude: lat as NSNumber, longitude: long as NSNumber) { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let data):
                self.serializeJson(requestData: data)
                print("OpenCage data -> ",data)
            }
        }
    }
        
    private func serializeJson(requestData: Data) {
        do {
            coordinateInfoModel = try JSONDecoder().decode(CageInfoModel.self, from: requestData)
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}

