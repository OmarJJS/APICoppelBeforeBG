//
//  UserViewModel.swift
//  APICoppel
//
//  Created by MacBookMBP1 on 17/11/22.
//

import Foundation

class UserViewModel {
    var requestToken = RequestToken(success: false, request_token: "", expires_at : "")
    func Login(user: User, Logear : @escaping (RequestToken?, Error?) -> Void){
        do{
            let decoder = JSONDecoder()
            let baseURL = "https://api.themoviedb.org/3/movie/550?api_key=a6ee74bc7ecd3e0f5c6a04dc9eef3bb8"
            let url = URL(string: baseURL)
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try! JSONEncoder().encode(user)
            
            let urlSession = URLSession.shared
            urlSession.dataTask(with: urlRequest){ data, response, error in
                guard let data = data else {
                    return
                }
                print("Data \(String(describing: data))")
                self.requestToken = try! decoder.decode(RequestToken.self, from: data)
                Logear(self.requestToken, nil)
            }.resume()
        }
    }
}
