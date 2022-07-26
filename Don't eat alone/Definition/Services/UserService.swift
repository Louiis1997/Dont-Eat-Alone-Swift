//
//  UserService.swift
//  Don't eat alone
//
//  Created by Louis Xia on 19/07/2022.
//

import Foundation

protocol UserService {
    func fetchUsers(completion: @escaping ([User]) -> Void)
    
    func fetchUserById(id: Int, completion: @escaping (User) -> Void)
    
    func fetchUserByEmail(email: String, completion: @escaping (User) -> Void)
    
    func getLoggedUser(token:String, completion: @escaping (User) -> Void)
    
    func updateUser(token: String, firstName: String, lastName: String, email: String, password: String, description: String)
}
