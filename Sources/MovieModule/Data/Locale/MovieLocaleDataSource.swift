//
//  File.swift
//  
//
//  Created by Putra on 16/06/22.
//

import Foundation
import Combine
import RealmSwift
import CoreFindOut

public struct MovieLocaleDataSource: LocaleDataSourceCore {
    public func cek(id: String) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    
    
    public typealias Request = Any
    public typealias Response = MovieListEntity
    
    private let realm: Realm
    
    public init(realm: Realm) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> MovieLocaleDataSource = { realm in
        return MovieLocaleDataSource(realm: realm!)
    }
    
    public func list(request: Any?) -> AnyPublisher<[MovieListEntity], Error> {
        return Future<[MovieListEntity], Error> { completion in
//            if let realm = self.realm {
                let moviePlay = realm.objects(MovieListEntity.self)
                completion(.success(moviePlay.toArray(ofType: MovieListEntity.self)))
//            }else {
//                completion(.failure(DatabaseError.invalidInstance))
//            }
        }.eraseToAnyPublisher()
    }
                                    
                                   
    public func add(entities: [MovieListEntity]) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
//            if let realm = self.realm {
                do {
                    try realm.write {
                        for data in entities {
                            realm.add(data, update: .all)
                        }
                        completion(.success(true))
                    }
                }catch {
                    completion(.failure(DatabaseError.requestFailed))
                }
//            }else {
//                completion(.failure(DatabaseError.invalidInstance))
//            }
        }.eraseToAnyPublisher()
    }
                                    
    public func get(id: String) -> AnyPublisher<MovieListEntity, Error> {
       fatalError()
    }
                                    
    public func update(id: Int, entity: MovieListEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func delete(object: MovieListEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    
    
    
    
}
