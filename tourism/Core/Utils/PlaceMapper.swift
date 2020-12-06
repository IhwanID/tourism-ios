//
//  PlaceMapper.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import Foundation

final class PlaceMapper {

    static func mapPlaceResponsesToEntities(
        input placeResponses: [PlaceResponse]
    ) -> [PlaceEntity] {
        return placeResponses.map { result in
            let place = PlaceEntity()
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

    static func mapPlaceEntitiesToDomains(
        input placeEntities: [PlaceEntity]
    ) -> [Place] {
        return placeEntities.map { result in
            return Place(id: result.id, name: result.name, desc: result.desc, address: result.address, longitude: result.longitude, latitude: result.latitude, like: result.like, image: result.image, favorite: result.favorite
            )
        }
    }

    static func mapPlaceResponsesToDomains(
        input placeResponses: [PlaceResponse]
    ) -> [Place] {

        return placeResponses.map { result in
            return Place(id: result.id ?? 0, name: result.name ?? "", desc: result.description ?? "", address: result.address ?? "", longitude: result.longitude ?? 0.0, latitude: result.latitude ?? 0.0, like: result.like ?? 0, image: result.image ?? ""
            )
        }
    }

    static func mapDetailPlaceEntityToDomain(
        input placeEntity: PlaceEntity
    ) -> Place {

        return Place(id: placeEntity.id, name: placeEntity.name, desc: placeEntity.desc, address: placeEntity.address, longitude: placeEntity.longitude , latitude: placeEntity.latitude , like: placeEntity.like, image: placeEntity.image, favorite: placeEntity.favorite
        )
    }

}
