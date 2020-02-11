//
//  ViewController.swift
//  GeoLibrary
//
//  Created by usr01 on 10.02.2020.
//  Copyright © 2020 bhdn. All rights reserved.
//

import UIKit
import Photos

class TableViewController: UIViewController, PassDataDelegate {
    
    func onLoadingCompleted(arrayOfAsset : [AssetInfoModel]) {
        self.assets = arrayOfAsset
    }
    
    @IBOutlet weak var photosDescriptionTable: UITableView!
    
    private let manager = PhotoManager.shared
    
    private var assets : [AssetInfoModel] = [AssetInfoModel]() {
        didSet {
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
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.delegate = self
        manager.loadPhotos()
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
}

