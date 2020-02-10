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
    
    let manager = PhotoManager.shared
    
    var assets : [AssetInfoModel] = [AssetInfoModel]() {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !manager.assets.isEmpty {
           assets = manager.assets
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
}

