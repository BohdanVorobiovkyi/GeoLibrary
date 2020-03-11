//
//  Observable.swift
//  GeoLibrary
//
//  Created by usr01 on 10.03.2020.
//  Copyright © 2020 bhdn. All rights reserved.
//

import Foundation


protocol Observable {
    associatedtype T
    var value: T {get set}
    var observers: [Observer] {get set}
    
    func addObserver(_ observer: Observer)
    func removeObserver(_ observer: Observer)
    func notifyObservers<T>(with newValue: T)
    
}
