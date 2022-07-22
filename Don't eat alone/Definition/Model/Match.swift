//
//  Match.swift
//  Don't eat alone
//
//  Created by Louis Xia on 22/07/2022.
//

import Foundation

class Match {
    var match: Bool
    
    init (match: Bool) {
        self.match = match
    }
    
    convenience init?(dict: [String: Any]) {
        guard let match = dict["match"] as? Bool else {
            return nil
        }
        self.init(match: match)
    }
}
