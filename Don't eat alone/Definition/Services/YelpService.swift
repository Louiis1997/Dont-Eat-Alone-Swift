//
//  YelpService.swift
//  Don't eat alone
//
//  Created by Louis Xia on 19/07/2022.
//

import Foundation

protocol YelpService {
    func fetchBussinesses(latitude: Double, longitude: Double, completion: @escaping ([RestaurantPreview]) -> Void)
    
    func fetchRestaurants(id: String, completion: @escaping (RestaurantDetail) -> Void)
}
