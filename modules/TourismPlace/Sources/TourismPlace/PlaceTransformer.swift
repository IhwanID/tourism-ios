//
//  File.swift
//  
//
//  Created by Ihwan ID on 12/02/21.
//

import Foundation
import Core

public struct PlaceTransformer: Mapper {
    public typealias Response = [PlaceResponse]
    public typealias Entity = [PlaceModuleEntity]
    public typealias Domain = [PlaceDomainModel]

    public init() {}

    public func transformResponseToEntity(response: [PlaceResponse]) -> [PlaceModuleEntity] {
        return response.map { result in
            let place = PlaceModuleEntity()
            place.id = result.id ?? 0
            place.name = result.name ?? "Unknow"
            place.image = result.image ?? "Unknow"
            place.desc = result.description ?? "Unknow"
            place.address = result.address ?? "Unknow"
            place.latitude = result.latitude ?? 0
            place.longitude = result.longitude ?? 0
            return place
        }
    }

    public func transformEntityToDomain(entity: [PlaceModuleEntity]) -> [PlaceDomainModel] {
        return entity.map { result in
            return PlaceDomainModel(
                id: result.id, name: result.name, desc: result.desc, address: result.address, longitude: result.longitude, latitude: result.latitude, like: result.like, image: result.image, favorite: result.favorite
            )
        }
    }
}
