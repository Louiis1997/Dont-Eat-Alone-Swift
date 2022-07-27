//
//  MessageService.swift
//  Don't eat alone
//
//  Created by Louis Xia on 21/07/2022.
//

import Foundation

protocol MessageService {
    func createMessage(token: String, receiverId: Int, content: String, completion: @escaping (Message) -> Void)
    
    func fetchMessages(token: String, userId: Int, completion: @escaping ([Message]) -> Void)
}
