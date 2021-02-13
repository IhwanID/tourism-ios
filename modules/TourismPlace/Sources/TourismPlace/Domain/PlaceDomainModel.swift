//
//  File.swift
//  
//
//  Created by Ihwan ID on 12/02/21.
//

import Foundation

public struct PlaceDomainModel: Equatable, Identifiable {

    public let id: Int
    public let name: String
    public let desc: String
    public let address: String
    public let longitude: Double
    public let latitude: Double
    public let like: Int
    public let image: String
    public var favorite: Bool = false

    enum CodingKeys: String, CodingKey{
        case desc = "description"

    }

    public init(id: Int, name: String, desc: String, address: String, longitude: Double, latitude: Double, like: Int, image: String, favorite: Bool){
        self.id = id
        self.name = name
        self.desc = desc
        self.address = address
        self.longitude = longitude
        self.latitude = latitude
        self.like = like
        self.image = image
        self.favorite = favorite

    }
}
