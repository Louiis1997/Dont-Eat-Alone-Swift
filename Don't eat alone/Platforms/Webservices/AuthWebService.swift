//
//  AuthWebService.swift
//  Don't eat alone
//
//  Created by Louis Xia on 21/07/2022.
//

import Foundation

class AuthWebService : AuthService {
    public static let shared: AuthService = AuthWebService()
    
    func AuthLogin(email: String, password: String, completion: @escaping (Token) -> Void) {
        let url = URL(string: "http://localhost:3000/api/auth/login")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = [
            "email": email,
            "password": password
        ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        } catch let error {
            print(error.localizedDescription)
            return
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Post Request Error: \(error.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  200 == httpResponse.statusCode else {
                print("Invalid Response received from the server: \((response as? HTTPURLResponse)!.statusCode)")
                return
            }
            guard let responseData = data else {
                print("nil Data received from the server")
                return
            }
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
                    let token = Token(dict: jsonResponse)
                    completion(token!)
                } else {
                    print("data maybe corrupted or in wrong format")
                    throw URLError(.badServerResponse)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func AuthRegister(firstName: String, lastName: String, email: String, password: String, description: String) {
        let url = URL(string: "http://localhost:3000/api/auth/register")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
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
                print("Post Request Error: \(err.localizedDescription)")
                return
            }
            guard let httpResponse = res as? HTTPURLResponse,
                  201 == httpResponse.statusCode else {
                print("Invalid Response received from the server: \((res as? HTTPURLResponse)!.statusCode)")
                return
            }
        }
        dataTask.resume()
    }
}
