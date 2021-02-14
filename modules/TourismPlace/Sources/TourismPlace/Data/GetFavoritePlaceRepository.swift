//
//  File.swift
//  
//
//  Created by Ihwan ID on 14/02/21.
//

import Foundation
import Core
import Combine

public struct GetFavoritePlaceRepository<
    PlaceLocaleDataSource: LocaleDataSource,
    Transformer: Mapper>: Repository
where
    PlaceLocaleDataSource.Response == PlaceModuleEntity,
    Transformer.Entity == [PlaceModuleEntity],
    Transformer.Domain == [PlaceDomainModel] {

    public typealias Request = Any
    public typealias Response = [PlaceDomainModel]

    private let _localeDataSource: PlaceLocaleDataSource
    private let _mapper: Transformer

    public init(
        localeDataSource: PlaceLocaleDataSource,
        mapper: Transformer) {

        _localeDataSource = localeDataSource
        _mapper = mapper
    }


    public func execute(request: Any?) -> AnyPublisher<[PlaceDomainModel], Error> {
        return _localeDataSource.getFavorite()
            .map { _mapper.transformEntityToDomain(entity: $0) }.eraseToAnyPublisher()
    }
}
