//
//  ChatViewController.swift
//  Don't eat alone
//
//  Created by Ilyess NAIT BELKACEM on 24/07/2022.
//

import UIKit

class ChatViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var MessageTextField: UITextField!
    var receiver: User!
    var sender: User!
    var messages: [Message]!
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var goBackButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    
    static func newInstance( sender : User, receiver: User, messages: [Message]) -> ChatViewController {
        let vc = ChatViewController()
        vc.sender = sender;
        vc.receiver = receiver;
        vc.messages = messages;
        return vc;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.MessageTextField.placeholder =
        NSLocalizedString("chat.message.placeholder", comment: "")
        self.MessageTextField.delegate = self
        self.messagesTableView.delegate = self
        self.NameLabel.text = receiver.firstName
        if let imageData = Data(base64Encoded: receiver.profilePicture) {
                    if let loadedImage = UIImage(data: imageData) {
                        self.avatarImageView.image = loadedImage
                    }
                }
        let cellNib = UINib(nibName: "ChatTableViewCell", bundle: nil)
        self.messagesTableView.register(cellNib, forCellReuseIdentifier: "MESSAGE_CELL")
        self.messagesTableView.dataSource = self;
    }


    @IBAction func handleGoBack(_ sender: Any) {
    }
    

    @IBAction func handleSendMessage(_ sender: Any) {
        guard let message = self.MessageTextField.text else {
            self.displayErrorMessage(title: NSLocalizedString("chat.message.alert.title", comment: ""), message: NSLocalizedString("chat.message.alert.empty", comment: ""))
            return
        }
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[0])
        let filePath = URL(fileURLWithPath: "token.txt", relativeTo: urls[0])
        do {
            guard let jwtToken = try? String(contentsOf: filePath) else {
                return
            }
            MessageWebService.shared.createMessage(token: jwtToken, receiverId: receiver.id, content: message) { message in
                self.messages.append(message)
                print(message)
            }
        }
        //call api for send message
        
    }
    
    func displayErrorMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("signin.form.alert.close", comment: ""), style: .cancel))
        self.present(alert, animated: true) {
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) {_ in
                alert.dismiss(animated: true)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "MESSAGE_CELL", for: indexPath) as! ChatTableViewCell;
        if (self.messages[indexPath.row].sender.id == sender.id){
        }
        cell.messageContentLabel.text = self.messages[indexPath.row].content
        cell.dateLabel.text = self.messages[indexPath.row].createdDate
        return cell;
    }
}
