//
//  RestaurantDetailViewController.swift
//  Don't eat alone
//
//  Created by Louis Xia on 27/07/2022.
//

import UIKit

class RestaurantDetailViewController: UIViewController, UITabBarDelegate {

    var restaurant: RestaurantDetail!
    
    static func newInstance(restaurant: RestaurantDetail) -> RestaurantDetailViewController {
        let vc = RestaurantDetailViewController()
        vc.restaurant = restaurant
        return vc
    }
    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var restaurantNotation: UILabel!
    @IBOutlet weak var restaurantAdress: UILabel!
    @IBOutlet weak var restaurantDistance: UILabel!
    @IBOutlet weak var restaurantNum: UILabel!
    @IBOutlet weak var restaurantPrice: UILabel!
    @IBOutlet weak var restaurantOpenBool: UILabel!
    @IBOutlet weak var startMatchingButton: UIButton!
    @IBOutlet weak var tabbar: UITabBar!
    @IBOutlet weak var homeItem: UITabBarItem!
    @IBOutlet weak var messageItem: UITabBarItem!
    @IBOutlet weak var profileItem: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeItem.title = NSLocalizedString("home.tabBarItem.home.title", comment: "")
        self.profileItem.title = NSLocalizedString("home.tabBarItem.profile.title", comment: "")
        self.startMatchingButton.setTitle(NSLocalizedString("restaurant.detail.start.button", comment: ""), for: .normal)
        self.tabbar.delegate = self
        var url = URL(string: restaurant.image_url)
        if url == nil {
            url = URL(string: "https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg")
        }
        if let imageData = try? Data(contentsOf: url!) {
            if let loadedImage = UIImage(data: imageData) {
                self.restaurantImage.image = loadedImage
            }
        }
        self.restaurantName.text = restaurant.name
        self.restaurantNotation.text = String(format: "%.1f", restaurant.rating) + " ⭐️ | " + String(restaurant.review_count) + " 🗳 "
        self.restaurantAdress.text = restaurant.location.display_address.joined(separator: " ")
        self.restaurantNum.text = restaurant.display_phone
        self.restaurantPrice.text = restaurant.price
        self.restaurantDistance.text = String(format: "%.1f", restaurant.distance / 1000) + " Km"
        if(restaurant.is_closed){
            self.restaurantOpenBool.text = "Closed"
        } else {
            self.restaurantOpenBool.text = "Opened"
        }
        // Do any additional setup after loading the view.
    }

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if(item == homeItem) {
            self.navigationController?.pushViewController(HomeViewController(), animated: true)
        } else if(item == messageItem) {
            self.navigationController?.pushViewController(MessageViewController(), animated: true)
        } else if(item == profileItem) {
            self.navigationController?.pushViewController(ProfileViewController(), animated: true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
