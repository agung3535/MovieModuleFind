//
//  File.swift
//  
//
//  Created by Putra on 16/06/22.
//

import Foundation
import CoreFindOut
import Combine
import Kingfisher

public struct MovieModuleRepo<MovieLocaleDataSource: LocaleDataSourceCore, MovieRemoteDataSource: MovieRemoteDataSourceCore, Transformer: Mapper>: MovieRepository where MovieLocaleDataSource.Response == MovieListEntity, MovieRemoteDataSource.Response == [MovieModuleListResult], Transformer.Response == [MovieModuleListResult], Transformer.Entity == [MovieListEntity], Transformer.Domain == [MovieModulePlayingModel] {
    
    
    
    public typealias Request = Any
    public typealias Response = [MovieModulePlayingModel]
    
    private let localeDataSource: MovieLocaleDataSource
    private let remoteDataSource: MovieRemoteDataSource
    private let mapper: Transformer
    
    public init(localeDataSource: MovieLocaleDataSource, remoteDataSource: MovieRemoteDataSource, mapper: Transformer) {
        self.mapper = mapper
        self.remoteDataSource = remoteDataSource
        self.localeDataSource = localeDataSource
    }
    
    public func execute(request: Any?, index: Int) -> AnyPublisher<[MovieModulePlayingModel], Error> {
        return localeDataSource.list(request: nil)
            .flatMap { result -> AnyPublisher<[MovieModulePlayingModel], Error> in
                if result.isEmpty {
                    return remoteDataSource.execute(request: nil, index: index)
                        .map { mapper.transformResponseToEntity(response: $0)}
                        .catch { _ in localeDataSource.list(request: nil)}
                        .flatMap({ self.localeDataSource.add(entities: $0)})
                        .flatMap { _ in localeDataSource.list(request: nil)
                                .map { mapper.transformEntityToDomain(entity: $0)}
                        }.eraseToAnyPublisher()
                }else {
                    return localeDataSource.list(request: nil)
                        .map { mapper.transformEntityToDomain(entity: $0)}
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
    public func add(request: Any?) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
}
