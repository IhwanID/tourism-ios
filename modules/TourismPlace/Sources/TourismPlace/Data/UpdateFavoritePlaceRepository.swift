//
//  File.swift
//  
//
//  Created by Ihwan ID on 13/02/21.
//

import Foundation
import Core
import Combine

public struct UpdateFavoritePlacesRepository<
    PlaceLocaleDataSource: LocaleDataSource,
    RemoteDataSource: DataSource,
    Transformer: Mapper>: Repository
where
    PlaceLocaleDataSource.Response == PlaceModuleEntity,
    RemoteDataSource.Response == [PlaceResponse],
    Transformer.Response == [PlaceResponse],
    Transformer.Entity == [PlaceModuleEntity],
    Transformer.Domain == [PlaceDomainModel] {



    public typealias Request = Any
    public typealias Response = [PlaceDomainModel]

    private let _localeDataSource: PlaceLocaleDataSource
    private let _remoteDataSource: RemoteDataSource
    private let _mapper: Transformer

    public init(
        localeDataSource: PlaceLocaleDataSource,
        remoteDataSource: RemoteDataSource,
        mapper: Transformer) {

        _localeDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }


    public func execute(request: Any?) -> AnyPublisher<[PlaceDomainModel], Error> {
        return _localeDataSource.get()
            .map { _mapper.transformEntityToDomain(entity: $0) }
            .eraseToAnyPublisher()
    }
}
