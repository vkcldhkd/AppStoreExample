//
//  SearchDetailViewReactor.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import ReactorKit
import RxSwift

final class SearchDetailViewReactor: Reactor {
    enum Action {
    }
    
    enum Mutation {
    }
    
    struct State {
        var model: SearchResult
        var section: [SearchDetailSection]
    }
    
    let initialState: State
    
    init(model: SearchResult) {
        defer { _ = self.state }
        self.initialState = State(
            model: model,
            section: SearchDetailViewReactor.createSection(model: model)
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        return .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        return state
    }
}


private extension SearchDetailViewReactor {
    static func createSection(model: SearchResult) -> [SearchDetailSection] {
        return [
            SearchDetailViewReactor.createInfoSection(model: model),
            SearchDetailViewReactor.createScreenshotSection(model: model),
            SearchDetailViewReactor.createDescSection(model: model)
        ]
    }
    
    static func createInfoSection(model: SearchResult) -> SearchDetailSection {
        let cellReactor: SearchItemCellReactor = SearchItemCellReactor(model: model, screenshotPrefixCount: nil)
        let infoItem: SearchDetailSectionItem = SearchDetailSectionItem.infoItem(cellReactor)
        let section: SearchDetailSection = SearchDetailSection.info([infoItem])
        return section
    }
    
    static func createScreenshotSection(model: SearchResult) -> SearchDetailSection {
        let cellReactor: SearchItemCellReactor = SearchItemCellReactor(model: model, screenshotPrefixCount: nil)
        let infoItem: SearchDetailSectionItem = SearchDetailSectionItem.screenshotItem(cellReactor)
        let section: SearchDetailSection = SearchDetailSection.screenshot([infoItem])
        return section
    }
    
    static func createDescSection(model: SearchResult) -> SearchDetailSection {
        let cellReactor: SeachDetailDescCellReactor = SeachDetailDescCellReactor(model: model)
        let infoItem: SearchDetailSectionItem = SearchDetailSectionItem.descItem(cellReactor)
        let section: SearchDetailSection = SearchDetailSection.desc([infoItem])
        return section
    }
}
