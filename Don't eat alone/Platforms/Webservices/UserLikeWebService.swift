//
//  UserLikeWebService.swift
//  Don't eat alone
//
//  Created by Louis Xia on 21/07/2022.
//

import Foundation

class UserLikeWebService : UserLikeService {
    public static let shared: UserLikeService = UserLikeWebService()
    
    func createUserLike(token:String, likedUserId: Int, completion: @escaping (Match) -> Void) {
        guard let url = URL(string: "http://localhost:3000/api/user-like") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let body: [String: Any] = [
            "likedUserId": likedUserId
        ]
        do {
           request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return
        }
          
        let dataTask = URLSession.shared.dataTask(with: request) { data, res, err in
            if let err = err {
                print("Create UserLike Request Error: \(err.localizedDescription)")
                return
            }
            guard let httpResponse = res as? HTTPURLResponse,
                  201 == httpResponse.statusCode else {
                print("Invalid Response received from the server")
                return
            }
            guard let responseData
                    = data else {
                return
            }
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? [String: Any] {
                    let match = Match(dict: jsonResponse)
                    completion(match!)
                } else {
                    print("data maybe corrupted or in wrong format")
                    throw URLError(.badServerResponse)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
    }
    
    func fetchUserLikeById(id: Int, completion: @escaping (UserLike) -> Void) {
        guard let url = URL(string: "http://localhost:3000/api/user-like/\(id)") else {
            return
        }
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: request) { data, res, err in
            if let err = err {
                print("Get UserLike By Id Request Error: \(err.localizedDescription)")
                return
            }
            guard let httpResponse = res as? HTTPURLResponse,
                200 == httpResponse.statusCode else {
                print("Invalid Response received from the server: \((res as? HTTPURLResponse)!.statusCode)")
                return
            }
            guard let fetchData = data,
                  let json = try? JSONSerialization.jsonObject(with: fetchData, options: .fragmentsAllowed),
                  let json =  json as? [String: Any] else {
                print("Json Serialization failed")
                return
            }
            guard let userLike = UserLike(dict: json) else {
                print("Mapping Json to UserLike failed")
                return
            }
            completion(userLike)
        }
        dataTask.resume()
    }
    
    func fetchLikedUser(id: Int, completion: @escaping ([LikedUser]) -> Void) {
        guard let url = URL(string: "http://localhost:3000/api/user-like/liked/\(id)") else {
            completion([])
            return
        }
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: request) { data, res, err in
            if let err = err {
                print("Get UserLiked Request Error: \(err.localizedDescription)")
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
                        .fragmentsAllowed) as? [[String: Any]] else {
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }
            let likedUser : [LikedUser] = json.compactMap { obj in
                return LikedUser(dict: obj)
            }
            DispatchQueue.main.async {
                completion(likedUser)
            }
        }
        dataTask.resume()
    }
    
    func fetchLikingUser(id: Int, completion: @escaping ([LikingUser]) -> Void) {
        guard let url = URL(string: "http://localhost:3000/api/user-like/liking/\(id)") else {
            completion([])
            return
        }
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: request) { data, res, err in
            if let err = err {
                print("Get UserLiking Request Error: \(err.localizedDescription)")
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
                        .fragmentsAllowed) as? [[String: Any]] else {
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }
            let likingUser : [LikingUser] = json.compactMap { obj in
                return LikingUser(dict: obj)
            }
            DispatchQueue.main.async {
                completion(likingUser)
            }
        }
        dataTask.resume()
    }
}
