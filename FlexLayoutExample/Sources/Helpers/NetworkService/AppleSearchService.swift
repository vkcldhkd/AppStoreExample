//
//  AppleSearchService.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import Foundation
import RxSwift

struct AppleSearchService {
    private static let baseURL: String = "https://itunes.apple.com/search?"
    static func getSearchResponse(
        keyword: String?,
        limit: Int = 20
    ) -> Observable<NetworkResponse<SearchResponse>?> {
        guard let keyword = keyword,
              !keyword.isEmpty else { return Observable.just(nil) }
        let queryItems: [URLQueryItem]? = AppleSearchService.createURLItems(keyword: keyword, limit: limit)
        let path: String = URLHelper.createAbsolutePath(baseURL: AppleSearchService.baseURL, queryItems: queryItems)
        
        return NetworkManager.request(method: .get, url: path)
            .map { try? NetworkResponse<SearchResponse>.init(path: path, json: $0) }
            .do(onNext: { _ in CoreDataHelper.search.action.addSearchKeyword(keyword: keyword) })
    }
    
    static func getSearchHistoryResponse(keyword: String?) -> Observable<[String]?> {
        let containKeywords = CoreDataHelper.search.action.loadKeywordHistory()
            .filter { $0.contains(keyword ?? "") }
        return Observable.just(containKeywords)
        
    }
}

private extension AppleSearchService {
    static func createURLItems(
        keyword: String,
        limit: Int
    ) -> [URLQueryItem]? {
        return [
            URLQueryItem(name: "country", value: "kr"), // 디바이스 언어로 설정 필요?
            URLQueryItem(name: "entity", value: "software"),
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "term", value: keyword)
        ]
    }
}
