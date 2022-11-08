//
//  APIService.swift
//  Rides
//
//  Created by Shraddha Jadeja on 2022-11-03.
//

import Foundation

enum ApiList: String {
    case getVehical = "https://random-data-api.com/api/vehicle/random_vehicle?size="        
}

class APIService: NSObject {
    
    func getVehicalData(size: String,completion: @escaping (Data?,Error?) -> ()){
        
        let api = URL(string: ApiList.getVehical.rawValue + size)
        
        URLSession.shared.dataTask(with: api!){
            data, response, error in
            if error != nil {
                completion(nil,error)
                return
            } else {
                completion(data,nil)
            }
        } .resume()
    }
}
