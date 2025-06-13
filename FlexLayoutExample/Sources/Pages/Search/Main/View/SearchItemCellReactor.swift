//
//  SearchItemCellReactor.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import ReactorKit
import RxSwift

final class SearchItemCellReactor: Reactor {
    enum Action {
        case download
    }
    
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
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .download:
            let downloadMutation = self.createDownloadMutation()
            return .concat([downloadMutation])
        }
    }
}


private extension SearchItemCellReactor {
    static func createScreenshotCellReactor(
        screenshotUrls: [String]?,
        screenshotPrefixCount: Int?
    ) -> [SearchScreenshotCellReactor] {
        
        var resultScreenshotUrls: [String] {
            guard let screenshotUrls = screenshotUrls else { return [] }
            guard let screenshotPrefixCount = screenshotPrefixCount else { return screenshotUrls }
            return Array(screenshotUrls.prefix(screenshotPrefixCount))
        }
        
        return resultScreenshotUrls
            .map { SearchScreenshotCellReactor(url: $0) }
    }
}

private extension SearchItemCellReactor {
    func createDownloadMutation() -> Observable<Mutation> {
        return BaseAlertController.present(
            title: "내 마음속에",
            message: "저장!",
            actions: [.init(title: "확인", style: .default)]
        ).flatMap { _ in Observable.empty() }
    }
}
