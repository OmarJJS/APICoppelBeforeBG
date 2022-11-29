//
//  Perfil.swift
//  APICoppel
//
//  Created by MacBookMBP1 on 17/11/22.
//

import Foundation
struct Perfil : Codable{
    let avatar : Avatar
    let id : Int
    let iso639_1, iso_3166_1, name : String
    let includeAdult : Bool
    let username : String
    
    enum CodinKeys : String, CodingKey {
        case avatar, id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name
        case includeAdult = "include_adult"
        case username
        }
}

struct Avatar : Codable {
    let gravatar : Gravatar
}

struct Gravatar : Codable {
    let hash : Double
}
