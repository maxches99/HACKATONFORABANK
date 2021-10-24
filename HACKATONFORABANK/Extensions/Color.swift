//
//  Color.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 24.10.2021.
//

import SwiftUI

extension Color {
    static var random: Color {
        return Color(
            red: .random(in: 1...1),
            green: .random(in: 0.3...0.9),
            blue: .random(in: 0.4...0.8)
        )
    }
}
