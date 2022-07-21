//
//  MessageViewController.swift
//  Don't eat alone
//
//  Created by Luigi on 16/07/2022.
//

import UIKit

class MessageViewController: UIViewController {

    @IBOutlet weak var listMessage: UITableView!
    
    @IBOutlet var listRestaurants: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
