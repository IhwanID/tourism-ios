//
//  LocalDataSource.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import Foundation
import RealmSwift
import Combine

protocol LocalDataSourceProtocol: class {

    func getPlaces() -> AnyPublisher<[PlaceEntity], Error>
    func addPlaces(from places: [PlaceEntity]) -> AnyPublisher<Bool, Error>
    func getFavoritePlaces() -> AnyPublisher<[PlaceEntity], Error>
    func updateFavoritePlace(by id: Int) -> AnyPublisher<PlaceEntity, Error>
}

final class LocalDataSource: NSObject {

    private let realm: Realm?

    private init(realm: Realm?) {
        self.realm = realm
    }

    static let sharedInstance: (Realm?) -> LocalDataSource = { realmDatabase in
        return LocalDataSource(realm: realmDatabase)
    }

}

extension LocalDataSource: LocalDataSourceProtocol {

    func getPlaces() -> AnyPublisher<[PlaceEntity], Error> {
        return Future<[PlaceEntity], Error> { completion in
            if let realm = self.realm {
                let places: Results<PlaceEntity> = {
                    realm.objects(PlaceEntity.self)
                        .sorted(byKeyPath: "name", ascending: true)
                }()
                completion(.success(places.toArray(ofType: PlaceEntity.self)))
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }

    func addPlaces(
        from places: [PlaceEntity]
    ) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for place in places {
                            realm.add(place, update: .all)
                        }
                        completion(.success(true))
                    }
                } catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
            } else {
                completion(.failure(DatabaseError.invalidInstance))
            }
        }.eraseToAnyPublisher()
    }

    func getFavoritePlaces() -> AnyPublisher<[PlaceEntity], Error> {
      return Future<[PlaceEntity], Error> { completion in
        if let realm = self.realm {
          let placeEntities = {
            realm.objects(PlaceEntity.self)
              .filter("favorite = \(true)")
              .sorted(byKeyPath: "name", ascending: true)
          }()
          completion(.success(placeEntities.toArray(ofType: PlaceEntity.self)))
        } else {
          completion(.failure(DatabaseError.invalidInstance))
        }
      }.eraseToAnyPublisher()
    }

    func updateFavoritePlace(
      by id: Int
    ) -> AnyPublisher<PlaceEntity, Error> {
      return Future<PlaceEntity, Error> { completion in
        if let realm = self.realm, let entity = {
          realm.objects(PlaceEntity.self).filter("id = \(id)")
        }().first {
          do {
            try realm.write {
                entity.setValue(!entity.favorite, forKey: "favorite")
            }
            completion(.success(entity))
          } catch {
            completion(.failure(DatabaseError.requestFailed))
          }
        } else {
          completion(.failure(DatabaseError.invalidInstance))
        }
      }.eraseToAnyPublisher()
    }

}

extension Results {

    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }

}
