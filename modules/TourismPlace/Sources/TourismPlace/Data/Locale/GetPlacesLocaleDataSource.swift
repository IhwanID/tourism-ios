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

    public func get() -> AnyPublisher<[PlaceModuleEntity], Error> {
        return Future<[PlaceModuleEntity], Error> { completion in
            let placeEntities = {
                _realm.objects(PlaceModuleEntity.self)
                    .filter("favorite = \(true)")
                    .sorted(byKeyPath: "name", ascending: true)
            }()
            completion(.success(placeEntities.toArray(ofType: PlaceModuleEntity.self)))
        }.eraseToAnyPublisher()
    }

       public func update(id: Int, entity: PlaceModuleEntity) -> AnyPublisher<PlaceModuleEntity, Error> {
        return Future<PlaceModuleEntity, Error> { completion in
            _realm.objects(PlaceModuleEntity.self).filter("id = \(id)")
            do {
                try _realm.write {
                    entity.setValue(!entity.favorite, forKey: "favorite")
                }
                completion(.success(entity))
            } catch {
                completion(.failure(DatabaseError.requestFailed))
            }

        }.eraseToAnyPublisher()
       }
}
