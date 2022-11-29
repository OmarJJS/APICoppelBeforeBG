//
//  Invited.swift
//  APICoppel
//
//  Created by MacBookMBP1 on 16/11/22.
//

import Foundation
final class Invited{
    func executeApi(){
        let urlSession = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/authentication/session/convert/4?api_key=a6ee74bc7ecd3e0f5c6a04dc9eef3bb8")
        urlSession.dataTask(with: url!){ data, response, error in
         print("Data \(String(describing: data))")
         print("Response \(String(describing: response))")
         print("Error \(String(describing: error))")
        }.resume()
    }
}
