//
//  ApiManager.swift
//  Hackaton
//
//  Created by Максим Чесников on 22.10.2021.
//

import Foundation

class ApiManager {
    static let sharedInstance: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        return URLSession(configuration: configuration)
    }()
}
