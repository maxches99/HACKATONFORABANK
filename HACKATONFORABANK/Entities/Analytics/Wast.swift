//
//  Wast.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 24.10.2021.
//

import Foundation

struct Wast: Codable, Identifiable {
    let amount: Double?
    let percent: Double?
    let type: TypeOfTransfer?
    
    var id: UUID {
        UUID()
    }
}
