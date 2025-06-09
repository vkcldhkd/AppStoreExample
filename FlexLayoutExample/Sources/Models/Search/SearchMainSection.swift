//
//  SearchMainSection.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import RxDataSources

enum SearchMainSection {
    case history([SearchMainSectionItem])
    case search([SearchMainSectionItem])
    case result([SearchMainSectionItem])
}

extension SearchMainSection: SectionModelType {
    var items: [SearchMainSectionItem] {
        switch self {
        case let .history(items): return items
        case let .search(items): return items
        case let .result(items): return items
        }
    }
    
    init(original: SearchMainSection, items: [SearchMainSectionItem]) {
        switch original {
        case .history: self = .history(items)
        case .search: self = .search(items)
        case .result: self = .result(items)
        }
    }
}

enum SearchMainSectionItem {
    case historyItem(SearchHistoryCellReactor)
    case searchItem(SearchItemCellReactor)
    case searchEmptyItem(String?)
}
