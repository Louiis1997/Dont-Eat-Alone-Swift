//
//  RestaurantViewController.swift
//  Don't eat alone
//
//  Created by Luigi on 20/07/2022.
//

import UIKit

class RestaurantViewController: UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var nomRestaurant: UILabel!
    
    @IBOutlet weak var imageRestaurant: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if(item.tag == 0) {
            self.navigationController?.pushViewController(ProfileViewController(), animated: true)
            } else if(item.tag == 1) {
                self.navigationController?.pushViewController(MessageViewController(), animated: true)
            } else if(item.tag == 2) {
                self.navigationController?.pushViewController(HomeViewController(), animated: true)
            }
        }
    

}
