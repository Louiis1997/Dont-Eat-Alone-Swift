//
//  RestaurantLikeByUser.swift
//  Don't eat alone
//
//  Created by Louis Xia on 19/07/2022.
//

import Foundation

class RestaurantLikeByUser {
    var id: Int
    var restaurantId: String
    
    init (id: Int, restaurantId: String) {
        self.id = id
        self.restaurantId = restaurantId
    }
    
    convenience init?(dict: [String: Any]) {
        guard let id = dict["id"] as? Int,
              let restaurantId = dict["restaurantId"] as? String else {
            return nil
        }
        
        self.init(id: id, restaurantId: restaurantId)
    }
}
