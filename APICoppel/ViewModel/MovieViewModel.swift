//
//  MovieV-M.swift
//  APICoppel
//
//  Created by MacBookMBP1 on 16/11/22.
//

import Foundation
class MovieViewModel{
    func GetFavoriteMovies(idSession : String, movie : @escaping (Movies , Error?) -> Void){
        let decoder = JSONDecoder()
        let urlSession = URLSession.shared
        let url = URL(string: "https://api.themoviedb.org/3/authentication/session/convert/4?api_key=a6ee74bc7ecd3e0f5c6a04dc9eef3bb8")
        urlSession.dataTask(with: url!){data, response, error in
            print("Data \(String(describing: data))")
            
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data)
                let movies = try! decoder.decode(Movies.self, from: data)
                movie(movies, nil)
            }
        }.resume()
    }
    
    func GetPopularMovie(movie : @escaping (Movies, Error?) -> Void){
        let urlSession = URLSession.shared
        let decoder = JSONDecoder()
        let url = URL(string: "https://api.themoviedb.org/3/authentication/session/convert/4?api_key=a6ee74bc7ecd3e0f5c6a04dc9eef3bb8")
        urlSession.dataTask(with: url!){ data, response, error in
            print("Data \(String(describing: data))")
            
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data)
                let movies = try! decoder.decode(Movies.self , from: data)
                movie(movies,nil)
//                print(String(describing: json))
            }
        }.resume()
    }
    
    func GetTopRatedMovie(movie: @escaping (Movies , Error?) -> Void){
        let urlSession = URLSession.shared
        let decoder = JSONDecoder()
        let url = URL(string: "https://api.themoviedb.org/3/authentication/session/convert/4?api_key=a6ee74bc7ecd3e0f5c6a04dc9eef3bb8")
        urlSession.dataTask(with: url!){ data, response, error in
            print("Data \(String(describing: data))")
            
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data)
                let movies = try! decoder.decode(Movies.self, from: data)
                movie(movies, nil)
//                print(String(describing: json))
            }
        }.resume()
    }
}
