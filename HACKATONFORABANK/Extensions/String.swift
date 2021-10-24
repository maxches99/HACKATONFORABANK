//
//  String.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 24.10.2021.
//

import Foundation

extension String: Identifiable {
    public var id: UUID {
        UUID()
    }
}
