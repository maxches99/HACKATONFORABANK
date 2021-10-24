//
//  DischargeAPI.swift
//  Hackaton
//
//  Created by Максим Чесников on 22.10.2021.
//

import Foundation

/// Listing requests to get Discharges
enum DischargeAPI {
    case getDischargesPerPage(Int, [FilterType])
}

extension DischargeAPI: APIBuilder {
    var urlRequest: URLRequest {
        switch self {
        case .getDischargesPerPage(let page, let filters):
            
            var request = URLRequest(url: baseUrl.appendingPathComponent(path))
            request.httpMethod = "POST"
            
            var parameters: [String: Any] = [
                "page": page
            ]
            
            filters.forEach { filter in
                switch filter {
                case .input:
                    parameters["directionType"] = "INSIDE"
                case .output:
                    parameters["directionType"] = "OUTSIDE"
                case .period(let startDate, let endDate):
                    var startDateString = ""
                    let startDateComponents = startDate.get(.day, .month, .year)
                    if let day = startDateComponents.day, let month = startDateComponents.month, let year = startDateComponents.year {
                        startDateString = "\(day).\(month).\(year)"
                    }
                    var endDateString = ""
                    let endDateComponents = endDate.get(.day, .month, .year)
                    if let day = endDateComponents.day, let month = endDateComponents.month, let year = endDateComponents.year {
                        endDateString = "\(day).\(month).\(year)"
                    }
                    parameters["period"] = "\(startDateString)-\(endDateString)"
                case .year:
                    parameters["tenor"] = "YEAR"
                case .month:
                    parameters["tenor"] = "MONTH"
                case .week:
                    parameters["tenor"] = "WEEK"
                case .day:
                    parameters["tenor"] = "DAY"
                case .summ(let sum):
                    parameters["sum"] = sum.rounded(toPlaces:2)
                case .summUp:
                    parameters["sumFilterType"] = "FILTER_BEFORE"
                case .summDown:
                    parameters["sumFilterType"] = "FILTER_AFTER"
                case .user(let name):
                    parameters["transferee"] = name
                }
            }
            
            
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            return request
        }
    }
    
    var path: String {
        return ""
    }
    
    
}
