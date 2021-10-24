//
//  Double.swift
//  HACKATONFORABANK
//
//  Created by Максим Чесников on 23.10.2021.
//

import Foundation

public extension Double {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    func toString(forCurrencyCode code: String) -> String {
        
        if let currency = getSymbol(forCurrencyCode: code) {
            return "\(self.clean) " + currency
        } else {
            return "\(self.clean) " + code
        }
    }
    
    func getSymbol(forCurrencyCode code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        if locale.displayName(forKey: .currencySymbol, value: code) == code {
            let newlocale = NSLocale(localeIdentifier: code.dropLast() + "_en")
            return newlocale.displayName(forKey: .currencySymbol, value: code)
        }
        return locale.displayName(forKey: .currencySymbol, value: code)
    }
    
    var decimalPlaces: Int {
        let decimals = String(self).split(separator: ".")[1]
        return decimals == "0" ? 0 : decimals.count
    }
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
