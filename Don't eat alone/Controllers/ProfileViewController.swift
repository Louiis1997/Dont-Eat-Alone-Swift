//
//  ProfileViewController.swift
//  Don't eat alone
//
//  Created by Luigi on 20/07/2022.
//

import UIKit

class ProfileViewController: UIViewController, UITabBarDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nom: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var prenom: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var personalStatementLabel: UILabel!
    @IBOutlet weak var personalStatement: UILabel!
    @IBOutlet weak var homeItem: UITabBarItem!
    @IBOutlet weak var messageItem: UITabBarItem!
    @IBOutlet weak var profilItem: UITabBarItem!
    @IBOutlet weak var tabbar: UITabBar!
    
    var userService: UserService = UserWebService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameLabel.text = NSLocalizedString("edit.lastname.placeholder", comment: "")
        self.firstNameLabel.text = NSLocalizedString("edit.firstname.placeholder", comment: "")
        self.personalStatementLabel.text = NSLocalizedString("edit.personalStatement.placeholder", comment: "")
        self.homeItem.title = NSLocalizedString("home.tabBarItem.home.title", comment: "")
        self.profilItem.title = NSLocalizedString("home.tabBarItem.profile.title", comment: "")
        self.tabbar.delegate = self
        
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
                    self.prenom.text = user.firstName
                    self.nom.text = user.lastName
                    self.email.text = user.email
                    self.personalStatement.text = user.description
                }
            }
        } catch {
            return
        }

        // Do any additional setup after loading the view.
    }
    
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if(item == homeItem) {
            self.navigationController?.pushViewController(HomeViewController(), animated: true)
        } else if(item == messageItem) {
            self.navigationController?.pushViewController(MessageViewController(), animated: true)
        }
    }
    
    @IBAction func editHandler(_ sender: Any) {
    }
}
