//
//  LikingUser.swift
//  Don't eat alone
//
//  Created by Louis Xia on 19/07/2022.
//

import Foundation

class LikingUser {
    var id: Int
    var likingUser: User
    
    init(id: Int, likingUser: User) {
        self.id = id
        self.likingUser = likingUser
    }
    
    convenience init?(dict: [String: Any]) {
        guard let id = dict["id"] as? Int,
              let likingUser = dict["likedUser"] as? [String: Any],
              let likingUserObject = User(dict: likingUser) else {
            return nil
        }
        
        self.init(id: id, likingUser: likingUserObject)
    }
}
