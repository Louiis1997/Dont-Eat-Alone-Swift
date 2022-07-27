//
//  UsersDMViewController.swift
//  Don't eat alone
//
//  Created by Ilyess NAIT BELKACEM on 26/07/2022.
//

import UIKit

class UsersDMViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var loggedUser: User!
    var token: String!
    var users: [User]!

    @IBOutlet weak var usersDmTableView: UITableView!
    
    static func newInstance(users: [User]) -> UsersDMViewController {
        let vc = UsersDMViewController()
        vc.users = users
        return vc;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let filePath = URL(fileURLWithPath: "token.txt", relativeTo: urls[0])
        do {
            self.token = try? String(contentsOf: filePath)
        }
        UserWebService.shared.getLoggedUser(token: token) { user in
            self.loggedUser = user
        }

        let cellNib = UINib(nibName: "MessageTableViewCell", bundle: nil)
        self.usersDmTableView.register(cellNib, forCellReuseIdentifier: "USER_MESSAGE_CELL")
        self.usersDmTableView.delegate = self;
        self.usersDmTableView.dataSource = self;
        // Do any additional setup after loading the view.
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = usersDmTableView.dequeueReusableCell(withIdentifier: "USER_MESSAGE_CELL", for: indexPath) as! MessageTableViewCell;
        cell.userNameLabel.text = self.users[indexPath.row].firstName
        
        if let imageData = Data(base64Encoded: self.users[indexPath.row].profilePicture) {
                    if let loadedImage = UIImage(data: imageData) {
                        cell.profilePictureImageView.image = loadedImage
                    }
                }
        if(self.loggedUser.id == self.users[indexPath.row].id){
            cell.isHidden = true;
        }
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.loggedUser.id != self.users[indexPath.row].id){
            MessageWebService.shared.fetchMessages(token: token, userId: self.users[indexPath.row].id) { messages in
                DispatchQueue.main.async {
                    let chat = ChatViewController.newInstance(sender: self.loggedUser, receiver: self.users[indexPath.row], messages: messages)
                    self.navigationController?.pushViewController(chat, animated: true)
                }
            }
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
