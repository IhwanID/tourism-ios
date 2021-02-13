//
//  File.swift
//  
//
//  Created by Ihwan ID on 12/02/21.
//

import Foundation
import Core
import Combine
import Alamofire
import Foundation

public struct GetPlacesRemoteDataSource : DataSource {

    public typealias Request = Any
       public typealias Response = [PlaceResponse]

       private let _endpoint: String

       public init(endpoint: String) {
           _endpoint = endpoint
       }

    public func execute(request: Any?) -> AnyPublisher<[PlaceResponse], Error> {
            return Future<[PlaceResponse], Error> { completion in
              if let url = URL(string: _endpoint) {
                AF.request(url)
                  .validate()
                  .responseDecodable(of: PlacesResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                      completion(.success(value.places))
                    case .failure:
                      completion(.failure(URLError.invalidResponse))
                    }
                  }
              }
            }.eraseToAnyPublisher()
        }


}
