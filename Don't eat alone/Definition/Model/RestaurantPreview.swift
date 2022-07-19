//
//  RestaurantPreview.swift
//  Don't eat alone
//
//  Created by Louis Xia on 19/07/2022.
//

import Foundation

class RestaurantPreview {
    var id: String
    var name: String
    var image_url: String
    var is_closed: Bool
    var review_count: Int
    var rating: Double
    var distance: Double
    
    init(id: String, name: String, image_url: String, is_closed: Bool, review_count: Int, rating: Double, distance: Double) {
        self.id = id
        self.name = name
        self.image_url = image_url
        self.is_closed = is_closed
        self.review_count = review_count
        self.rating = rating
        self.distance = distance
    }
    
    convenience init?(dict: [String: Any]) {
        guard let id = dict["id"] as? String,
              let name = dict["name"] as? String,
              let image_url = dict["image_url"] as? String,
              let is_closed = dict["is_closed"] as? Bool,
              let review_count = dict["review_count"] as? Int,
              let rating = dict["rating"] as? Double,
              let distance = dict["distance"] as? Double else {
            return nil
        }
        
        self.init(id: id, name: name, image_url: image_url, is_closed: is_closed, review_count: review_count, rating: rating, distance: distance)
    }
}
