//
//  API builder.swift
//  Hackaton
//
//  Created by Максим Чесников on 22.10.2021.
//

import Foundation

protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var path: String { get }
}

extension APIBuilder {
    var baseUrl: URL {
        return URL(string: "http://192.168.43.247:8087/forabank1/")!
    }
}
