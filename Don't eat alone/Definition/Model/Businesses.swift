//
//  Businesses.swift
//  Don't eat alone
//
//  Created by Louis Xia on 19/07/2022.
//

import Foundation

class Businesses {
    var businesses: [RestaurantPreview]
    
    init(businesses: [RestaurantPreview]) {
        self.businesses = businesses
    }
    
    convenience init?(dict: [String: Any]) {
        guard let businesses = dict["businesses"] as? [RestaurantPreview] else {
            return nil
        }
        
        self.init(businesses: businesses)
    }
}
