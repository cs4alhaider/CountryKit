//
//  Country.swift
//  EasyTools
//
//  Created by Abdullah Alhaider on 14/03/2020.
//  Copyright © 2020 Abdullah Alhaider. All rights reserved.
//

import Foundation
import Helper4Swift

public struct Country: Codable, Identifiable, Equatable {
    
    public init(name: String?, dialCode: String?, code: String?) {
        self.name = name
        self.dialCode = dialCode
        self.code = code
    }
    
    public let id = UUID()
    public let name: String?
    public let dialCode: String?
    public let code: String?
    

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case dialCode = "dial_code"
        case code = "code"
    }
    
    public var flag: String? {
        code?
            .unicodeScalars
            .map({ 127397 + $0.value })
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
    
    public var localName: String? {
        // let locale = Locale.init(identifier: "ar_SA") // Don't use this
        if let name = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: code ?? "SA") {
            // Country name was found
            return name
        } else {
            // Country name cannot be found
            return name ?? "SA"
        }
    }
    
    public static var allCountries: [Country] {
        Bundle.countryKit.decode([Country].self, from: "countryCodes.json")
    }
    
    public static var currentCountry: Country? {
        let code = lastSelectedCountryCode ?? Locale.current.regionCode?.uppercased() ?? "SA"
        return allCountries.first(where: {$0.code == code})
    }
    
    private static var lastSelectedCountryCode: String? {
        UserDefaults.countryKit.value(forKey: "lastSelectedCountry") as? String
    }
}

public extension UserDefaults {
    static var countryKit: UserDefaults = {
        return UserDefaults(suiteName: "net.alhaider.CountryKit") ?? standard
    }()
}

public extension Foundation.Bundle {
    static var countryKit: Bundle {
        return .module
    }
}
