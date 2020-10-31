//
//  PlaceEntity.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import Foundation
import RealmSwift

class PlaceEntity: Object {

  @objc dynamic var id: String = ""
  @objc dynamic var title: String = ""
  @objc dynamic var image: String = ""
  @objc dynamic var desc: String = ""

  override static func primaryKey() -> String? {
    return "id"
  }
}
