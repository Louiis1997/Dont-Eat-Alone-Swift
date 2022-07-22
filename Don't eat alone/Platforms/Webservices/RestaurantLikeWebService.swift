//
//  RestaurantLikeWebService.swift
//  Don't eat alone
//
//  Created by Louis Xia on 21/07/2022.
//

import Foundation

class RestaurantLikeWebService : RestaurantLikeService {
    public static let shared: RestaurantLikeService = RestaurantLikeWebService()
    func createRestaurantLike(token: String, restaurantId: String) {
        guard let url = URL(string: "http://localhost:3000/api/restaurant-like") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let body: [String: Any] = [
            "restaurantId": restaurantId
        ]
        do {
           request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return
        }
          
        let dataTask = URLSession.shared.dataTask(with: request) { data, res, err in
            if let err = err {
                print("Create RestaurantLike Request Error: \(err.localizedDescription)")
                return
            }
            guard let httpResponse = res as? HTTPURLResponse,
                  201 == httpResponse.statusCode else {
                print("Invalid Response received from the server")
                return
            }
        }
        dataTask.resume()
    }
    
    func fetchRestaurantLikeByUserId(id: Int, completion: @escaping ([RestaurantLikeByUser]) -> Void) {
        guard let url = URL(string: "http://localhost:3000/api/restaurant-like/user/\(id)") else {
            completion([])
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: request) { data, res, err in
            if let err = err {
                print("Get RestaurantLike By UserId Request Error: \(err.localizedDescription)")
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
                        .fragmentsAllowed) as? [[String: Any]]  else {
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }
            let restaurantLike: [RestaurantLikeByUser] = json.compactMap { obj in
                return RestaurantLikeByUser(dict: obj)
            }
            DispatchQueue.main.async {
                completion(restaurantLike)
            }
        }
        dataTask.resume()
    }
    
    func fetchRestaurantLikeById(id: Int, completion: @escaping (RestaurantLike) -> Void) {
        guard let url = URL(string: "http://localhost:3000/api/restaurant-like/\(id)") else {
            return
        }
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: request) { data, res, err in
            if let err = err {
                print("Get RestaurantLike By Id Request Error: \(err.localizedDescription)")
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
            guard let restaurantLike = RestaurantLike(dict: json) else {
                print("Mapping Json to RestaurantLike failed")
                return
            }
            completion(restaurantLike)
        }
        dataTask.resume()
    }
    
    func fetchRestaurantLikeByRestaurantId(restaurantId: String, completion: @escaping ([RestaurantLike]) -> Void) {
        guard let url = URL(string: "http://localhost:3000/api/restaurant-like/restaurant/\(restaurantId)") else {
            completion([])
            return
        }
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: request) { data, res, err in
            if let err = err {
                print("Get RestaurantLike By RestaurantId Request Error: \(err.localizedDescription)")
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
            let restaurantLike : [RestaurantLike] = json.compactMap { obj in
                return RestaurantLike(dict: obj)
            }
            DispatchQueue.main.async {
                completion(restaurantLike)
            }
        }
        dataTask.resume()
    }
}
