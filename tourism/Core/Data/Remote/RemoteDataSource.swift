//
//  RemoteDataSource.swift
//  tourism
//
//  Created by Ihwan ID on 01/11/20.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol: class {

    func getPlaces() -> AnyPublisher<[PlaceResponse], Error>

}

final class RemoteDataSource: NSObject {

    private override init() { }

    static let sharedInstance: RemoteDataSource =  RemoteDataSource()

}

extension RemoteDataSource: RemoteDataSourceProtocol {

    func getPlaces() -> AnyPublisher<[PlaceResponse], Error> {
        return Future<[PlaceResponse], Error> { completion in
            if let url = URL(string: "https://tourism-api.dicoding.dev/list") {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: PlacesResponse.self) { response in
                        switch response.result {
                        case .success(let value): completion(.success(value.places))
                        case .failure: completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
