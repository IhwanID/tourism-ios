//
//  Place.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import Foundation

struct Place: Equatable, Identifiable {

    let id: Int
    let name: String
    let desc: String
    let address: String
    let longitude: Double
    let latitude: Double
    let like: Int
    let image: String
    var favorite: Bool = false
    
    enum CodingKeys: String, CodingKey{
        case desc = "description"

    }
}
