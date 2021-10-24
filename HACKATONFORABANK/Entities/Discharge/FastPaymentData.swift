//
//  FastPaymentData.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 24.10.2021.
//

import Foundation

struct FastPaymentData: Codable {
    let foreignName, foreignPhoneNumber, foreignBankBIC, foreignBankID: String
    let foreignBankName: String
    let documentComment: String
}
