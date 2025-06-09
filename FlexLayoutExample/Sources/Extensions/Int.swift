//
//  Int.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import Foundation

extension Int {
    // https://stackoverflow.com/questions/36376897/swift-2-0-format-1000s-into-a-friendly-ks
    func shorted() -> String {
        if self >= 1000 && self < 10000 {
            return String(format: "%.1fk", Double(self/100)/10).replacingOccurrences(of: ".0", with: "")
        }
        
        if self >= 10000 && self < 1000000 {
            return "\(self/1000)k"
        }
        
        if self >= 1000000 && self < 10000000 {
            return String(format: "%.1fM", Double(self/100000)/10).replacingOccurrences(of: ".0", with: "")
        }
        
        if self >= 10000000 {
            return "\(self/1000000)M"
        }
        
        return String(self)
    }
}
