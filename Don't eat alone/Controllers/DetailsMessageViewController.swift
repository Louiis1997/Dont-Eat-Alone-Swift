//
//  DetailsMessageViewController.swift
//  Don't eat alone
//
//  Created by Luigi on 16/07/2022.
//

import UIKit

class DetailsMessageViewController: UIViewController {

    @IBOutlet weak var nomInterlocuteur: UILabel!
    @IBOutlet weak var photoInterlocuteur: UIImageView!
    
    @IBOutlet weak var saisieMessage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func sendMessage(_ sender: Any) {
        
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
