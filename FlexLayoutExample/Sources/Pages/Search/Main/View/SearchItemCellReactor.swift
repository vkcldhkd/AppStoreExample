//
//  SearchItemCellReactor.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import ReactorKit
import RxSwift

final class SearchItemCellReactor: Reactor {
    typealias Action = NoAction
    struct State {
        var model: SearchResult
        var screenshotCellReactor: [SearchScreenshotCellReactor]
    }
    
    let initialState: State
    
    init(
        model: SearchResult,
        screenshotPrefixCount: Int?
    ) {
        defer { _ = self.state }
        self.initialState = State(
            model: model,
            screenshotCellReactor: SearchItemCellReactor.createScreenshotCellReactor(
                screenshotUrls: model.screenshotUrls,
                screenshotPrefixCount: screenshotPrefixCount
            )
        )
    }
}


private extension SearchItemCellReactor {
    static func createScreenshotCellReactor(
        screenshotUrls: [String]?,
        screenshotPrefixCount: Int?
    ) -> [SearchScreenshotCellReactor] {
        
        var resultScreenshotUrls: [String] {
            guard var screenshotUrls = screenshotUrls else { return [] }
            guard let screenshotPrefixCount = screenshotPrefixCount else { return screenshotUrls }
            return Array(screenshotUrls.prefix(screenshotPrefixCount))
        }
        
        return resultScreenshotUrls
            .map { SearchScreenshotCellReactor(url: $0) }
    }
}
