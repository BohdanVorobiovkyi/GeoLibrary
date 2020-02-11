//
//  Observable.swift
//  GeoLibrary
//
//  Created by usr01 on 11.02.2020.
//  Copyright © 2020 bhdn. All rights reserved.
//

import Foundation





class PhotManager {
    class Photo {
        func print() {
        }
    }
    private var observers = Array<Photo>()
    
    func addObserver(_ obj: Photo) {
        observers.append(obj)
    }
    func removeObserver(_ obj: Photo) {
//        observers.remove
    }
    func notify() {
        observers.forEach { ($0 as Photo).print() }
    }
    func loadPhotos(obj: Photo) {
        if !(observers.contains { $0 === obj }) {
            addObserver(obj)
        }
        notify()
    }
    deinit {
        observers.removeAll()
    }
}
