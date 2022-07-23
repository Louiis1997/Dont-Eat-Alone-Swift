//
//  MessageWebService.swift
//  Don't eat alone
//
//  Created by Louis Xia on 21/07/2022.
//

import Foundation

class MessageWebService : MessageService {
    public static let shared: MessageService = MessageWebService()
    
    func createMessage(token: String, receiverId: Int, content: String) {
        guard let url = URL(string: "http://localhost:3000/api/messages") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = [
            "receiverId": receiverId,
            "content": content
        ]
        do {
           request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            return
        }
          
        let dataTask = URLSession.shared.dataTask(with: request) { data, res, err in
            if let err = err {
                print("Create Message Request Error: \(err.localizedDescription)")
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
    
    func fetchMessages(token: String, completion: @escaping ([Message]) -> Void) {
        guard let url = URL(string: "http://localhost:3000/api/messages") else {
            completion([])
            return
        }
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let dataTask = URLSession.shared.dataTask(with: request) { data, res, err in
            if let err = err {
                print("Get Messages Send To Request Error: \(err.localizedDescription)")
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
            let messages : [Message] = json.compactMap { obj in
                return Message(dict: obj)
            }
            DispatchQueue.main.async {
                completion(messages)
            }
        }
        dataTask.resume()
    }
}
