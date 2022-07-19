//
//  LikedUser.swift
//  Don't eat alone
//
//  Created by Louis Xia on 19/07/2022.
//

import Foundation

class LikedUser {
    var id: Int
    var likedUser: User
    
    init(id: Int, likedUser: User) {
        self.id = id
        self.likedUser = likedUser
    }
    
    convenience init?(dict: [String: Any]) {
        guard let id = dict["id"] as? Int,
              let likedUser = dict["likedUser"] as? [String: Any],
              let likedUserObject = User(dict: likedUser) else {
            return nil
        }
        
        self.init(id: id, likedUser: likedUserObject)
    }
}
