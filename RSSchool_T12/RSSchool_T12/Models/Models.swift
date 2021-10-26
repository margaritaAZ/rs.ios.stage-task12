//
//  Data.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 23.09.21.
//

import Foundation

struct WalletModel {
    var title: String
    var cash: Int
    var lastChange: Date
}

struct CurrencyModel {
    static let defaultCode: String = "BYN"
    var name: String = ""
    var code: String
    
    static func getSymbol(forCurrencyCode code: String) -> String? {
        let locale = NSLocale(localeIdentifier: code)
        return locale.displayName(forKey: .currencySymbol, value: code)
    }
}
