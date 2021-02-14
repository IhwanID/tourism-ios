//
//  File.swift
//  
//
//  Created by Ihwan ID on 12/02/21.
//

import Foundation
import Combine
import RealmSwift
import Core

public struct GetPlacesLocaleDataSource: LocaleDataSource {

    public typealias Request = Any
    public typealias Response = PlaceModuleEntity

    private let _realm: Realm

    public init(realm: Realm) {
        _realm = realm
    }

    public func list(request: Any?) -> AnyPublisher<[PlaceModuleEntity], Error> {
        return Future<[PlaceModuleEntity], Error> { completion in
            let places: Results<PlaceModuleEntity> = {
                _realm.objects(PlaceModuleEntity.self)
                    .sorted(byKeyPath: "name", ascending: true)
            }()
            completion(.success(places.toArray(ofType: PlaceModuleEntity.self)))

        }.eraseToAnyPublisher()
    }

    public func add(entities: [PlaceModuleEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                try _realm.write {
                    for place in entities {
                        _realm.add(place, update: .all)
                    }
                    completion(.success(true))
                }
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }

        }.eraseToAnyPublisher()
    }

    public func getFavorite() -> AnyPublisher<[PlaceModuleEntity], Error> {
        return Future<[PlaceModuleEntity], Error> { completion in
            let placeEntities = {
                _realm.objects(PlaceModuleEntity.self)
                    .filter("favorite = \(true)")
                    .sorted(byKeyPath: "name", ascending: true)
            }()
            completion(.success(placeEntities.toArray(ofType: PlaceModuleEntity.self)))
        }.eraseToAnyPublisher()
    }

    public func get(id: Int) -> AnyPublisher<PlaceModuleEntity, Error> {
        return Future<PlaceModuleEntity, Error> { completion in
            if let placeEntity = {
                _realm.objects(PlaceModuleEntity.self).filter("id = \(id)")
            }().first {
                completion(.success(placeEntity))
            }else {
                completion(.failure(DatabaseError.invalidInstance))
            }

        }.eraseToAnyPublisher()
    }

    public func update(id: Int) -> AnyPublisher<PlaceModuleEntity, Error> {
        return Future<PlaceModuleEntity, Error> { completion in
            if let placeEntity = {
                _realm.objects(PlaceModuleEntity.self).filter("id = \(id)")
            }().first {
                do {
                    let temp = placeEntity.favorite
                    try _realm.write {
                        placeEntity.setValue(!temp, forKey: "favorite")
                    }
                    completion(.success(placeEntity))
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            }else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }
}
