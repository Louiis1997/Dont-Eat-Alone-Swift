//
//  HomeTableViewCell.swift
//  Don't eat alone
//
//  Created by Louis Xia on 26/07/2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var RestaurantPhoto: UIImageView!
    @IBOutlet weak var RestaurantName: UILabel!
    @IBOutlet weak var RestaurantNotation: UILabel!
    @IBOutlet weak var RestaurantDistance: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likedButton: UIButton!
    
    var restaurantId: String = "";
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func likeHandler(_ sender: Any) {
        self.likeButton.isHidden = true
        self.likedButton.isHidden = false
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let filePath = URL(fileURLWithPath: "token.txt", relativeTo: urls[0])
        do {
            let data = try Data(contentsOf: filePath)
            let token = String(decoding: data, as: UTF8.self)
            RestaurantLikeWebService.shared.createRestaurantLike(token: token, restaurantId: restaurantId)
        } catch {
            return
        }
    }
    
    @IBAction func unlikeHandler(_ sender: Any) {
        self.likeButton.isHidden = false
        self.likedButton.isHidden = true
    }
    
    func setRestaurant(_ restaurant: RestaurantDetail) {
        self.restaurantId = restaurant.id
        var url = URL(string: restaurant.image_url)
        if url == nil {
            url = URL(string: "https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg")
        }
        if let imageData = try? Data(contentsOf: url!) {
            if let loadedImage = UIImage(data: imageData) {
                self.RestaurantPhoto.image = loadedImage
            }
        }
        self.RestaurantName.text = restaurant.name
        self.RestaurantNotation.text = String(format: "%.1f", restaurant.rating) + " ⭐️ | " + String(restaurant.review_count) + " 🗳 "
        self.RestaurantDistance.text = String(format: "%.1f", restaurant.distance / 1000) + " Km"
    }
}
