//
//  AuthDataset.swift
//  Don't eat alone
//
//  Created by Louis Xia on 18/07/2022.
//

import Foundation

class Token {
    var access_token: String
    
    init (access_token: String) {
        self.access_token = access_token
    }
    
    convenience init?(dict: [String: Any]) {
        guard let access_token = dict["access_token"] as? String else {
            return nil
        }
        self.init(access_token: access_token)
    }
}
