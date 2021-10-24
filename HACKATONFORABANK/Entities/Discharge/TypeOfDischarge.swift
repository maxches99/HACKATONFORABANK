//
//  TypeOfDischarge.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 24.10.2021.
//

import Foundation

enum TypeOfDischarge: String, Codable {
    case inside = "INSIDE"
    case outside = "OUTSIDE"
    
    var name: String {
        switch self {
        case .inside:
            return "Входящий платеж"
        case .outside:
            return "Исходящий платеж"
        }
    }
}
