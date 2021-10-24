//
//  MonthAPI.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 24.10.2021.
//

import Foundation

enum MonthAPI {
    case getMonthInfo(Date)
    case getMonths
}

extension MonthAPI: APIBuilder {
    var urlRequest: URLRequest {
        switch self {
        case .getMonthInfo(let date):
            
            var request = URLRequest(url: baseUrl.appendingPathComponent(path))
            request.httpMethod = "POST"
            
            
            var dateString = ""
            let startDateComponents = date.get(.month, .year)
            if let month = startDateComponents.month, let year = startDateComponents.year {
                dateString = "\(month).\(year)"
            }
            
            var parameters: [String: Any] = [
                "date": dateString
            ]
            
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            return request
        case .getMonths:
            var request = URLRequest(url: baseUrl.appendingPathComponent(path))
            request.httpMethod = "GET"
           
            
            return request
        }
    }
    
    var path: String {
        switch self {
        case .getMonthInfo:
            return "month"
        case .getMonths:
            return "graph"
        }
    }
    
    
}
