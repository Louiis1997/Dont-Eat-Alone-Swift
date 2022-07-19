//
//  RestaurentLike.swift
//  Don't eat alone
//
//  Created by Louis Xia on 18/07/2022.
//

import Foundation

class RestaurantLike {
    var id: Int
    var restaurantId: String
    var user: User
    
    init(id: Int, restaurantId: String, user: User) {
        self.id = id
        self.restaurantId = restaurantId
        self.user = user
    }
    
    convenience init?(dict: [String: Any]) {
        guard let id = dict["id"] as? Int,
              let restaurantId = dict["restaurantId"] as? String,
              let user = dict["user"] as? [String: Any],
              let userObject = User(dict: user) else {
            return nil
        }
        
        self.init(id: id, restaurantId: restaurantId, user: userObject)
    }
}
