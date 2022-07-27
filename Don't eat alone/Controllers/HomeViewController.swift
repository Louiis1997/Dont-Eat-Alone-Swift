//
//  HomeViewController.swift
//  Don't eat alone
//
//  Created by Louis Xia on 26/07/2022.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, CLLocationManagerDelegate, UITabBarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var restaurantTableView: UITableView!
    @IBOutlet weak var homeItem: UITabBarItem!
    @IBOutlet weak var profilItem: UITabBarItem!
    @IBOutlet weak var messageItem: UITabBarItem!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var tabbar: UITabBar!
    @IBOutlet weak var restaurantsIndicatorView: UIActivityIndicatorView!
    
    
    var userService: UserService = UserWebService()
    var locationManager: CLLocationManager!
    var location: String?
    var currentLocation: CLLocation? {
        didSet {
            self.location = self.currentLocation?.description
        }
    }
    var lockLocation: Bool = true
    var restaurantService: YelpService = YelpWebService()
    var restaurants: [RestaurantPreview] = [] {
        didSet {
            self.restaurantTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeItem.title = NSLocalizedString("home.tabBarItem.home.title", comment: "")
        self.profilItem.title = NSLocalizedString("home.tabBarItem.profile.title", comment: "")
        self.logoutButton.setTitle(NSLocalizedString("home.disconnect.button", comment: ""), for: .normal)
        self.logoutButton.setTitleColor(UIColor.red, for: .normal)
        self.tabbar.delegate = self
        let cellNib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        self.restaurantTableView.register(cellNib, forCellReuseIdentifier: "RESTAURANT_CELL_ID")
        self.restaurantTableView.delegate = self
        self.restaurantTableView.dataSource = self
        self.restaurantsIndicatorView.startAnimating()
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.restaurantService.fetchBussinesses(latitude: 48.913789, longitude: 2.360566) { restaurants in
            self.restaurantsIndicatorView.stopAnimating()
            self.restaurants = restaurants
        }
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let filePath = URL(fileURLWithPath: "token.txt", relativeTo: urls[0])
        do {
            let data = try Data(contentsOf: filePath)
            let token = String(decoding: data, as: UTF8.self)
            self.userService.getLoggedUser(token: token) { user in
                let image = Data(base64Encoded: user.profilePicture)
                if image != nil {
                    DispatchQueue.main.async {
                        self.profileImage.image = UIImage(data: image!)
                    }
                }
                DispatchQueue.main.async {
                    self.firstName.text = user.firstName
                    self.lastName.text = user.lastName
                }
                
            }
        } catch {
            return
        }
    }
    
    @IBAction func logoutHandler(_ sender: Any) {
        self.navigationController?.pushViewController(SigninViewController(), animated: true)
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if(item == homeItem) {
            self.restaurantTableView.reloadData()
        } else if(item == messageItem) {
            self.navigationController?.pushViewController(MessageViewController(), animated: true)
        } else if(item == profilItem) {
            self.navigationController?.pushViewController(ProfileViewController(), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let restaurant = self.restaurants[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RESTAURANT_CELL_ID", for: indexPath) as! HomeTableViewCell
        cell.setRestaurant(restaurant)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restaurant = self.restaurants[indexPath.row]
        print(restaurant.name)
    }
}
