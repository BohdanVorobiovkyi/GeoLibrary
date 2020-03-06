//
//  NetworkService.swift
//  GeoLibrary
//
//  Created by usr01 on 13.02.2020.
//  Copyright © 2020 bhdn. All rights reserved.
//

import Foundation

class NetworkService {
    
    enum networkResult: Swift.Error {
        case noValidUrl
        case wrongPath
        case noData
        case errorOccured
        case unknownError
    }
    
    static func reverseGeocoding(latitude: NSNumber, longitude: NSNumber, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        let apiKey = "c7c131fafc4c4a99a917e69ab57b4b8c"
        
        func baseURL() -> String {
            return "https://api.opencagedata.com/geocode/v1/json?key="
        }
        
        func escapeCharacters(_ string :String) -> String {
            let customAllowedSet =  CharacterSet(charactersIn:"\"#%/<>?@\\^`{|}+, ").inverted
            let escapedString = string.addingPercentEncoding(withAllowedCharacters: customAllowedSet)
            return escapedString! as String
        }
        
        let latLongString = String(format: "%@,%@", latitude.stringValue, longitude.stringValue)
        let urlString = String(format: "%@%@&language=en&pretty=1&q=%@", baseURL(), escapeCharacters(apiKey), escapeCharacters(latLongString))
        
        guard let url = URL(string: urlString) else {return}
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        request.httpMethod = "GET"
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)
        
        let task = session.dataTask(with: request) { (data, response, err) in
            guard let _:Data = data, let _:URLResponse = response, err == nil else {
                completionBlock(.failure(networkResult.errorOccured))
                return
            }
            guard let _data = data else {return}
            completionBlock(.success(_data))
        }
        task.resume()
    }
}
