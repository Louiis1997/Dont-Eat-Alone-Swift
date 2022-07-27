//
//  RestaurentDataset.swift
//  Don't eat alone
//
//  Created by Louis Xia on 18/07/2022.
//

import Foundation

class RestaurantDetail {
    var id: String
    var name: String
    var image_url: String
    var is_closed: Bool
    var review_count: Int
    var rating: Double
    var price: String?
    var location: RestaurantLocation
    var distance: Double
    var display_phone: String
    
    init(id: String, name: String, image_url: String, is_closed: Bool, review_count: Int, rating: Double, price: String?, location: RestaurantLocation, distance: Double, display_phone: String) {
        self.id = id
        self.name = name
        self.image_url = image_url
        self.is_closed = is_closed
        self.review_count = review_count
        self.rating = rating
        self.price = price
        self.location = location
        self.distance = distance
        self.display_phone = display_phone
    }
    
    convenience init?(dict: [String: Any]) {
        guard let id = dict["id"] as? String,
              let name = dict["name"] as? String,
              let image_url = dict["image_url"] as? String,
              let is_closed = dict["is_closed"] as? Bool,
              let review_count = dict["review_count"] as? Int,
              let rating = dict["rating"] as? Double,
              let price = dict["price"] as? String?,
              let location = dict["location"] as? [String: Any],
              let locationObject = RestaurantLocation(dict: location),
              let distance = dict["distance"] as? Double,
              let display_phone = dict["display_phone"] as? String else {
            return nil
        }
        
        self.init(id: id, name: name, image_url: image_url, is_closed: is_closed, review_count: review_count, rating: rating, price: price, location: locationObject, distance: distance, display_phone: display_phone)
    }
}
