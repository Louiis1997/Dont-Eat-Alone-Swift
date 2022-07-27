//
//  YelpService.swift
//  Don't eat alone
//
//  Created by Louis Xia on 19/07/2022.
//

import Foundation

protocol YelpService {
    func fetchBussinesses(radius: Int, latitude: Double, longitude: Double, completion: @escaping ([RestaurantDetail]) -> Void)
}
