//
//  UserWebService.swift
//  Don't eat alone
//
//  Created by Louis Xia on 21/07/2022.
//

import Foundation

class UserWebService : UserService {
    public static let shared: UserService = UserWebService()
    
    func fetchUserById(id: Int, completion: @escaping (User) -> Void) {
        guard let url = URL(string: "http://localhost:3000/api/users/id/\(id)") else {
            return
        }
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: request) { data, res, err in
            if let err = err {
                print("Get By UserId Request Error: \(err.localizedDescription)")
                return
            }
            guard let httpResponse = res as? HTTPURLResponse,
                  200 == httpResponse.statusCode else {
                print("Invalid Response received from the server: \((res as? HTTPURLResponse)!.statusCode)")
                return
            }
            guard let fetchData = data,
            let json = try? JSONSerialization.jsonObject(with: fetchData, options: .allowFragments),
                  let json =  json as? [String: Any] else {
                print("Json Serialization failed")
                return
            }
            guard let user = User(dict: json) else {
                print("Mapping Json to User failed")
                return
            }
            completion(user)
        }
        dataTask.resume()
    }
    
    func fetchUserByEmail(email: String, completion: @escaping (User) -> Void) {
        guard let url = URL(string: "http://localhost:3000/api/users/email/\(email)") else {
            return
        }
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: request) { data, res, err in
            if let err = err {
                print("Get By User Email Request Error: \(err.localizedDescription)")
                return
            }
            guard let httpResponse = res as? HTTPURLResponse,
                  200 == httpResponse.statusCode else {
                print("Invalid Response received from the server: \((res as? HTTPURLResponse)!.statusCode)")
                return
            }
            guard let fetchData = data,
            let json = try? JSONSerialization.jsonObject(with: fetchData, options: .allowFragments),
                  let json =  json as? [String: Any] else {
                print("Json Serialization failed")
                return
            }
            guard let user = User(dict: json) else {
                print("Mapping Json to User failed")
                return
            }
            completion(user)
        }
        dataTask.resume()
    }
    
    func getLoggedUser(token:String, completion: @escaping (User) -> Void) {
        
        guard let url = URL(string: "http://localhost:3000/api/users/logged") else {
                return
        }
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, res, err in
            if let err = err {
                print("Get logged User Request Error: \(err.localizedDescription)")
                return
            }
            guard let httpResponse = res as? HTTPURLResponse,
                  200 == httpResponse.statusCode else {
                print("Invalid Response received from the server: \((res as? HTTPURLResponse)!.statusCode)")
                return
            }
            guard let fetchData = data,
            let json = try? JSONSerialization.jsonObject(with: fetchData, options: .allowFragments),
                  let json =  json as? [String: Any] else {
                print("Json Serialization failed")
                return
            }
            guard let user = User(dict: json) else {
                print("Mapping Json to User failed")
                return
            }
            completion(user)
        }
        dataTask.resume()
    }
    
    func updateUser(token:String, firstName: String, lastName: String, email: String, password: String, description: String) {
        
        guard let url = URL(string: "http://localhost:3000/api/users") else {
                return
        }
        var request = URLRequest(url: url)
            request.httpMethod = "PATCH"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let body: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "password": password,
            "description": description
        ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, res, err in
            if let err = err {
                print("Update User Request Error: \(err.localizedDescription)")
                return
            }
            guard let httpResponse = res as? HTTPURLResponse,
                  200 == httpResponse.statusCode else {
                print("Invalid Response received from the server")
                return
            }
        }
        dataTask.resume()
    }
    
    func fetchUsers(completion: @escaping ([User]) -> Void) {
        guard let url = URL(string: "http://localhost:3000/api/users") else {
            completion([])
            return
        }
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: request) { data, res, err in
            if let err = err {
                print("Get Users Request Error: \(err.localizedDescription)")
                return
            }
            guard let httpResponse = res as? HTTPURLResponse,
                  200 == httpResponse.statusCode else {
                print("Invalid Response received from the server: \((res as? HTTPURLResponse)!.statusCode)")
                return
            }
            guard err == nil,
                let fetchData = data,
                let json = try? JSONSerialization.jsonObject(with: fetchData, options:
                        .fragmentsAllowed) as? [[String: Any]]
            else {
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }
            let users: [User] = json.compactMap { obj in
                return User(dict: obj)
            }
            DispatchQueue.main.async {
                completion(users)
            }
        }
        dataTask.resume()
    }
}
