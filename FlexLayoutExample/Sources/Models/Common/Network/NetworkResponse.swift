//
//  NetworkResponse.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/13/24.
//

import Foundation
import Codextended

struct NetworkResponse<T: Codable>{
    var result: Int?
    var dateTime: String?
    var path: String?
    var data: T?
}

extension NetworkResponse {
    init(
        path: String?,
        json: [String: Any]?
    ) throws {
        guard let originalJson = json else { return }
        guard let jsonToData = originalJson.toData() else { return }
        
        do {
            self = NetworkResponse(
                result: originalJson.count > 0 ? 1 : 0,
                dateTime: "\(Date())",
                path: path,
                data: try jsonToData.decoded() as T
            )
        } catch {
            print("NetworkResponse Init Error: \(error)")
        }

    }
}
