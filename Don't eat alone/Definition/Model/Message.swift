//
//  Message.swift
//  Don't eat alone
//
//  Created by Louis Xia on 21/07/2022.
//

import Foundation

class Message {
    var id: Int
    var sender: User
    var receiver: User
    var createdDate: String
    var content: String
    
    init(id: Int, sender: User, receiver: User, createdDate: String, content: String) {
        self.id = id
        self.sender = sender
        self.receiver = receiver
        self.createdDate = createdDate
        self.content = content
    }
    
    convenience init?(dict: [String: Any]) {
        guard let id = dict["id"] as? Int,
              let sender = dict["sender"] as? [String: Any],
              let senderObject = User(dict: sender),
              let receiver = dict["receiver"] as? [String: Any],
              let receiverObject = User(dict: receiver),
              let createdDate = dict["createdDate"] as? String,
              let content = dict["content"] as? String else {
            return nil
        }
        
        self.init(id: id, sender: senderObject, receiver: receiverObject, createdDate: createdDate, content: content)
    }
}
