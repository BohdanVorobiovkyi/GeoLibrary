//
//  CageInfoModel.swift
//  GeoLibrary
//
//  Created by usr01 on 13.02.2020.
//  Copyright © 2020 bhdn. All rights reserved.


import Foundation

// MARK: - CageInfoModel
struct CageInfoModel: Codable {
    
    let results: [ResultModel]

    enum CodingKeys: String, CodingKey {
        case results
    }
    
    init() {
            results = [ResultModel]()
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            results = try container.decodeIfPresent(Array<ResultModel>.self, forKey: .results) ?? [ResultModel]()
        }
}
// MARK: - ResultModel
struct ResultModel: Codable {
    
    let components: Components
    
    enum CodingKeys: String, CodingKey {
           case components
       }
    
    init() {
        components = Components()
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        components = try container.decodeIfPresent(Components.self, forKey: .components) ?? Components()
    }
    
}

// MARK: - Components
struct Components: Codable {
    
    let city, cityDistrict, continent, country: String

    enum CodingKeys: String, CodingKey {
        case city
        case cityDistrict = "city_district"
        case continent, country
    }
    
    init() {
        self.city = ""
        self.cityDistrict = ""
        self.continent = ""
        self.country = ""
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        city = try container.decodeIfPresent(String.self, forKey: .city) ?? ""
        cityDistrict = try container.decodeIfPresent(String.self, forKey: .cityDistrict) ?? ""
        continent = try container.decodeIfPresent(String.self, forKey: .continent) ?? ""
        country = try container.decodeIfPresent(String.self, forKey: .country) ?? ""
    }
}
