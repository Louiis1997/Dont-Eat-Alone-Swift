//
//  YelpWebService.swift
//  Don't eat alone
//
//  Created by Louis Xia on 19/07/2022.
//

import Foundation

class YelpWebService : YelpService {
    public static let shared: YelpService = YelpWebService()
    
    let apikey = "DnEs9Ad38uZpvudTOXlbouFH13v2xA6ZUCaiLl3EMgf2oXiOcwwd1BvZzAYvSc0dmGu6UZe4nPI9eJiE3AMMx_jJx_yKTiscuiLmd985B5xgjtOcUmXas5HeoUbQYnYx"
    
    func fetchBussinesses(radius: Int, latitude: Double, longitude: Double, completion: @escaping ([RestaurantDetail]) -> Void) {
        guard let url = URL(string: "https://api.yelp.com/v3/businesses/search?term=restaurant&latitude=\(latitude)&longitude=\(longitude)&radius=\(radius)&sort_by=distance") else {
            completion([])
            return
        }
        var request = URLRequest(url: url)
            request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
        let dataTask = URLSession.shared.dataTask(with: request) { data, res, err in
            if let err = err {
                print("Get Nearby Restaurants Request Error: \(err.localizedDescription)")
                return
            }
            guard let httpResponse = res as? HTTPURLResponse,
                  200 == httpResponse.statusCode else {
                print("Invalid Response received from the server: \((res as? HTTPURLResponse)!.statusCode)")
                return
            }
            guard err == nil,
                let fetchData = data,
                let json = try? JSONSerialization.jsonObject(with: fetchData, options: .allowFragments) as? [String: Any],
                let businesses = json["businesses"] as? [[String: Any]]
            else {
                DispatchQueue.main.async {
                    completion([])
                }
                return
            }
            let RestaurantObjects: [RestaurantDetail] = businesses.compactMap { obj in
                return RestaurantDetail(dict: obj)
            }
            DispatchQueue.main.async {
                completion(RestaurantObjects)
            }
        }
        dataTask.resume()
    }
}
