//
//  File.swift
//  
//
//  Created by Putra on 16/06/22.
//

import Foundation
import CoreFindOut
import Combine
import Alamofire

public struct MovieRemoteDataSource: MovieRemoteDataSourceCore {
    
    public typealias Request = Any
    
    public typealias Response = [MovieModuleListResult]
    
    private let endPoint: [String]
    
    public init(endPoint: [String]) {
        self.endPoint = endPoint
    }
    
   
    
    public func execute(request: Any?, index: Int) -> AnyPublisher<[MovieModuleListResult], Error> {
        return Future<[MovieModuleListResult], Error> { completion in
            if let url = URL(string: endPoint[index]) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: MovieModuleResponse.self, completionHandler: { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.results ?? []))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    })
            }
        }.eraseToAnyPublisher()
    }
    
}
