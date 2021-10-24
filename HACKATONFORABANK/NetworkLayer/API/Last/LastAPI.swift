//
//  LastAPI.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 24.10.2021.
//

import Foundation

enum LastAPI {
    case getLasts
}

extension LastAPI: APIBuilder {
    var urlRequest: URLRequest {
        switch self {
        case .getLasts:
            
            var request = URLRequest(url: baseUrl.appendingPathComponent(path))
            request.httpMethod = "GET"
            
            return request
        }
    }
    
    var path: String {
        return "last"
    }
    
    
}
