//
//  RequestToken.swift
//  APICoppel
//
//  Created by MacBookMBP1 on 16/11/22.
//

import Foundation
struct RequestToken: Codable {
    
    let success : Bool
    let request_token : String
    let expires_at : String
    
//    let requestToken : String
//    enum CodingKeys: String, CodingKey{
//        case requestToken = "requestToken"
//    }
//}
//extension Token{
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.requestToken = try container.decode(String.self, forKey: .requestToken)
//    }
    
}
