//
//  People.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 24.10.2021.
//

import Foundation

struct People: Codable, Identifiable, Hashable {
    let count: Double?
    let percent: Double?
    let name: String?
    
    var id: UUID {
        UUID()
    }
    
}
