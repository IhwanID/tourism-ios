//
//  PlaceResponse.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import Foundation

struct PlacesResponse: Decodable {

  let places: [PlaceResponse]

}

struct PlaceResponse: Decodable {

    let id: Int?
    let name: String?
    let description: String?
    let address: String?
    let longitude: Double?
    let latitude: Double?
    let like: Int?
    let image: String?

}
