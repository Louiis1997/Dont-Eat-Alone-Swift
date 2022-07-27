//
//  MessageViewController.swift
//  Don't eat alone
//
//  Created by Luigi on 16/07/2022.
//

import UIKit

class MessageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var users: [User]!
    
    @IBOutlet var messagesTableView: UITableView!
    static func newInstance(users: [User]) -> MessageViewController {
        let vc = MessageViewController()
        vc.users = users
        return vc;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let cellNib = UINib(nibName: "MessageTableViewCell", bundle: nil)
        self.messagesTableView.register(cellNib, forCellReuseIdentifier: "USER_MESSAGE_CELL")
        self.messagesTableView.delegate = self;
        self.messagesTableView.dataSource = self;
        
        
        
        
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "USER_MESSAGE_CELL", for: indexPath) as! MessageTableViewCell;
        cell.userNameLabel.text = self.users[indexPath.row].firstName
        
        if let imageData = Data(base64Encoded: self.users[indexPath.row].profilePicture) {
                    if let loadedImage = UIImage(data: imageData) {
                        cell.profilePictureImageView.image = loadedImage
                    }
                }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let filePath = URL(fileURLWithPath: "token.txt", relativeTo: urls[0])
        do {
            guard let token = try? String(contentsOf: filePath) else {
                return
            }
            UserWebService.shared.getLoggedUser(token: token) { user in
                MessageWebService.shared.fetchMessages(token: token, userId: self.users[indexPath.row].id) { messages in
                    DispatchQueue.main.async {
                        let chat = ChatViewController.newInstance(sender: user, receiver: self.users[indexPath.row], messages: [])
                        self.navigationController?.pushViewController(chat, animated: true)
                    }
                }
            }
        }
    }
}
