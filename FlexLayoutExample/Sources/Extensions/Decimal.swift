//
//  Decimal.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import Foundation

extension Decimal {
    var doubleValue:Double {
        return NSDecimalNumber(decimal:self).doubleValue
    }
}
