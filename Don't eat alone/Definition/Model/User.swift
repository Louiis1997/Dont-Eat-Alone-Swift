//
//  User.swift
//  Don't eat alone
//
//  Created by Louis Xia on 18/07/2022.
//

import Foundation

class User: CustomStringConvertible {
    var id: Int
    var firstName: String
    var lastName: String
    var email: String
    var description: String
    var profilePicture: String
    
    init(id: Int, firstName: String, lastName: String, email: String, description: String, profilePicture: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.description = description
        self.profilePicture = profilePicture
    }
    
    convenience init?(dict: [String: Any]) {
        guard let id = dict["id"] as? Int,
              let firstName = dict["firstName"] as? String,
              let lastName = dict["lastName"] as? String,
              let email = dict["email"] as? String,
              let description = dict["description"] as? String,
              let profilePicture = dict["profilePicture"] as? String? ?? "" else {
            return nil
        }
        self.init(id: id, firstName: firstName, lastName: lastName, email: email, description: description, profilePicture: profilePicture)
    }
}
