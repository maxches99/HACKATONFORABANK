//
//  TypeOfOperation.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 24.10.2021.
//

import Foundation

enum TypeOfOperation: String, Codable {
    case debit = "DEBIT"
    case credit = "CREDIT"
    
    var name: String {
        switch self {
        case .debit:
            return "Дебетовая операция"
        case .credit:
            return "Кредитная операция"
        }
    }
}
