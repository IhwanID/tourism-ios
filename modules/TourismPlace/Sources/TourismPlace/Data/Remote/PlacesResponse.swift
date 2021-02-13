//
//  File.swift
//  
//
//  Created by Ihwan ID on 12/02/21.
//

import Foundation

public struct PlacesResponse: Decodable {

    let places: [PlaceResponse]

}

public struct PlaceResponse: Decodable {

    let id: Int?
    let name: String?
    let description: String?
    let address: String?
    let longitude: Double?
    let latitude: Double?
    let like: Int?
    let image: String?
}
