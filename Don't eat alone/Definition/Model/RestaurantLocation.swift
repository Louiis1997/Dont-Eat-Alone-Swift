//
//  RestaurantLocation.swift
//  Don't eat alone
//
//  Created by Louis Xia on 19/07/2022.
//

import Foundation

class RestaurantLocation {
    var display_address: [String]
    
    init(display_address: [String]) {
        self.display_address = display_address
    }
    
    convenience init?(dict: [String: Any]) {
        guard let display_address = dict["display_address"] as? [String] else {
            return nil
        }
        
        self.init(display_address: display_address)
    }
}
