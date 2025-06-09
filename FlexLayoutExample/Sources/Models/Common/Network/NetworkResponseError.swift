//
//  NetworkResponseError.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/13/24.
//

import Foundation

struct NetworkResponseError: Codable, Equatable {
    var code: Int?
    var message: String?
    var detailCode: Int?
    
    func getMessage(message: String) -> String {
        return self.message ?? message
    }
}
