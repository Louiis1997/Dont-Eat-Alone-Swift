//
//  UserLikeService.swift
//  Don't eat alone
//
//  Created by Louis Xia on 19/07/2022.
//

import Foundation

protocol UserLikeService {
    func fetchUserLikeById(id: Int, completion: @escaping (UserLike) -> Void)
    
    func fetchLikedUser(id: Int, completion: @escaping ([LikedUser]) -> Void)
    
    func fetchLikingUser(id: Int, completion: @escaping ([LikingUser]) -> Void)
    
    func createUserLike(token: String, likedUserId: Int, completion: @escaping (Match) -> Void)
}
