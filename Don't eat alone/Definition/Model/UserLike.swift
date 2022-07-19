//
//  UserLike.swift
//  Don't eat alone
//
//  Created by Louis Xia on 18/07/2022.
//

import Foundation

class UserLike {
    var id: Int
    var likedUser: User
    var likingUser: User
    
    init(id: Int, likedUser: User, likingUser: User) {
        self.id = id
        self.likedUser = likedUser
        self.likingUser = likingUser
    }
    
    convenience init?(dict: [String: Any]) {
        guard let id = dict["id"] as? Int,
              let likedUser = dict["likedUser"] as? [String: Any],
              let likedUserObject = User(dict: likedUser),
              let likingUser = dict["likingUser"] as? [String: Any],
              let likingUserObject = User(dict: likingUser) else {
            return nil
        }
        
        self.init(id: id, likedUser: likedUserObject, likingUser: likingUserObject)
    }
}
