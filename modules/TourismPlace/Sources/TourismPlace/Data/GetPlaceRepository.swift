//
//  File.swift
//  
//
//  Created by Ihwan ID on 14/02/21.
//

import Foundation
import Core
import Combine

public struct GetPlaceRepository<
    PlaceLocaleDataSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
    PlaceLocaleDataSource.Response == PlaceModuleEntity,
    Transformer.SingleEntity == PlaceModuleEntity,
    Transformer.SingleDomain == PlaceDomainModel {

    public typealias Request = Int
    public typealias Response = PlaceDomainModel

    private let _localeDataSource: PlaceLocaleDataSource
    private let _mapper: Transformer

    public init(
        localeDataSource: PlaceLocaleDataSource,
        mapper: Transformer) {

        _localeDataSource = localeDataSource
        _mapper = mapper
    }


    public func execute(request: Int?) -> AnyPublisher<PlaceDomainModel, Error> {
        return _localeDataSource.get(id: request ?? 0)
            .map { _mapper.transformSingleEntityToDomain(result: $0) }
            .eraseToAnyPublisher()
    }
}
