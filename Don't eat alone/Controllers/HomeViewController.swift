//
//  MatchViewController.swift
//  Don't eat alone
//
//  Created by Luigi on 21/07/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var photoProfil: UIImageView!
    @IBOutlet weak var labelNom: UILabel!
    @IBOutlet weak var labelPrenom: UILabel!
    @IBOutlet weak var listRestaurant: UITableView!
    
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
