//
//  NetworkService.swift
//  Hackaton
//
//  Created by Максим Чесников on 22.10.2021.
//

import Foundation
import Combine

final class NetworkService {
    
    func request<T: Codable>(from endpoint: APIBuilder) -> AnyPublisher<T, APIError> {
        
        return ApiManager
            .sharedInstance
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError { error in
                APIError.unknown
            }
            .flatMap { data, response -> AnyPublisher<T, APIError> in
                
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    
                    let jsonDecoder = JSONDecoder()
                    
                    return Just(data)
                        .decode(type: T.self, decoder: jsonDecoder)
                        .mapError { _ in APIError.decodingError}
                        .eraseToAnyPublisher()
                    
                } else {
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
