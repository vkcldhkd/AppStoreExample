//
//  String.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import Foundation

extension String {
    var trimmed: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
