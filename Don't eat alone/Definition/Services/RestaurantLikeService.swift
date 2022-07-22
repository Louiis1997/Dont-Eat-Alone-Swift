//
//  RestaurantLikeService.swift
//  Don't eat alone
//
//  Created by Louis Xia on 19/07/2022.
//

import Foundation

protocol RestaurantLikeService {
    func fetchRestaurantLikeByUserId(id: Int, completion: @escaping ([RestaurantLikeByUser]) -> Void)
    
    func fetchRestaurantLikeById(id: Int, completion: @escaping (RestaurantLike) -> Void)
    
    func fetchRestaurantLikeByRestaurantId(restaurantId: String, completion: @escaping ([RestaurantLike]) -> Void)
    
    func createRestaurantLike(token: String, restaurantId: String)
    
}
