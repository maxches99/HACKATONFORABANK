//
//  DischargeResponse.swift
//  Hackaton
//
//  Created by Максим Чесников on 22.10.2021.
//

import Foundation

struct DischargeResponse: Codable {
    let ableToPagination: Bool?
    let countOfPages: Int?
    let currentPage: Int?
    let operations: [Discharge]
}

extension DischargeResponse {
    static var data: DischargeResponse = DischargeResponse(
        ableToPagination: true,
        countOfPages: 10,
        currentPage: 1,
        operations: [Discharge.data]
    )
}
