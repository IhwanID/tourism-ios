//
//  File.swift
//  
//
//  Created by Ihwan ID on 10/02/21.
//

import Foundation
import Combine

public protocol LocaleDataSource {
    associatedtype Request
    associatedtype Response

    func list(request: Request?) -> AnyPublisher<[Response], Error>
    func add(entities: [Response]) -> AnyPublisher<Bool, Error>
    func getFavorite() -> AnyPublisher<[Response], Error>
    func update(id: Int, entity: Response) -> AnyPublisher<Response, Error>
}
