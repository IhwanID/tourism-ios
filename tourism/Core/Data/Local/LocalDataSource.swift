//
//  LocalDataSource.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import Foundation
import RealmSwift

protocol LocalDataSourceProtocol: class {

  func getPlaces(result: @escaping (Result<[PlaceEntity], DatabaseError>) -> Void)
  func addPlaces(
    from categories: [PlaceEntity],
    result: @escaping (Result<Bool, DatabaseError>) -> Void
  )

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

  func getPlaces(
    result: @escaping (Result<[PlaceEntity], DatabaseError>) -> Void
  ) {
    if let realm = realm {
      let categories: Results<PlaceEntity> = {
        realm.objects(PlaceEntity.self)
          .sorted(byKeyPath: "title", ascending: true)
      }()
      result(.success(categories.toArray(ofType: PlaceEntity.self)))
    } else {
      result(.failure(.invalidInstance))
    }
  }

  func addPlaces(
    from categories: [PlaceEntity],
    result: @escaping (Result<Bool, DatabaseError>) -> Void
  ) {
    if let realm = realm {
      do {
        try realm.write {
          for category in categories {
            realm.add(category, update: .all)
          }
          result(.success(true))
        }
      } catch {
        result(.failure(.requestFailed))
      }
    } else {
      result(.failure(.invalidInstance))
    }
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
