//
//  CageInfoModel.swift
//  GeoLibrary
//
//  Created by usr01 on 13.02.2020.
//  Copyright © 2020 bhdn. All rights reserved.


import Foundation

// MARK: - CageInfoModel
struct CageInfoModel: Codable {
    var results: [ResultModel]
}
// MARK: - ResultModel
struct ResultModel: Codable {
    var components: Components
}
// MARK: - Components
struct Components: Codable {
    
    var city: String?
    var cityDistrict: String?
    var continent: String?
    var country: String?
    
    enum CodingKeys: String, CodingKey {
        case city
        case cityDistrict = "city_district"
        case continent, country
    }
}
