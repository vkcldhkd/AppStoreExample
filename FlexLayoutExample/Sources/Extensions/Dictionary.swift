//
//  Dictionary.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import Foundation

extension Dictionary {
    func toData(options: JSONSerialization.WritingOptions = []) -> Data?{
        do {
            return try JSONSerialization.data(withJSONObject: self, options: options)
        } catch {
            print("Dictionary toData Error: \(error)")
            return nil
        }
    }
}
