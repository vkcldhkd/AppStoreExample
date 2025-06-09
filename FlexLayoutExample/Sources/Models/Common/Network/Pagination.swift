//
//  Pagination.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/13/24.
//

import Foundation

// MARK: - Pagination
struct Pagination: Codable, Equatable {
    let lastPage, pagePerCount: Int?
    var currentPage: Int?
    var fingerprint: String?
}

extension Pagination {
    func hasNextPage() -> Bool {
        if let _ = self.fingerprint {
            return true
        } else {
            let currentPage = self.currentPage ?? 0
            let lastPage = self.lastPage ?? 0
            return currentPage < lastPage
        }
    }
    
    func hasPreviousPage() -> Bool {
        let currentPage = self.currentPage ?? 0
        return currentPage > 0
    }
}
