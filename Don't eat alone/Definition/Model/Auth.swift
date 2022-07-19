//
//  AuthDataset.swift
//  Don't eat alone
//
//  Created by Louis Xia on 18/07/2022.
//

import Foundation

class Auth {
    var token: String
    
    init (token: String) {
        self.token = token
    }
    
    convenience init?(dict: [String: Any]) {
        guard let token = dict["token"] as? String else {
            return nil
        }
        self.init(token: token)
    }
}
