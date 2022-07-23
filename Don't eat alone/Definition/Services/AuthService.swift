//
//  AuthService.swift
//  Don't eat alone
//
//  Created by Louis Xia on 19/07/2022.
//

import Foundation

protocol AuthService {    
    func AuthLogin(email:String, password: String, completion: @escaping (Bool) -> Void)
    
    func AuthRegister(firstName: String, lastName: String, email: String, password: String, description: String)
}
