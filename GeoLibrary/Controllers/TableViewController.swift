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
   
    func onValueChanged(_ value: Any?) {
        self.assets = value as! [AssetInfoModel]
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
        manager.addObserver(self)
        self.title = "Photos Table"
        photosDescriptionTable.dataSource = self
        photosDescriptionTable.delegate = self
        manager.loadPhotos()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        manager.delegate = self

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

