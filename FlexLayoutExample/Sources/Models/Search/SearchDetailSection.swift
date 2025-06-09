//
//  SearchDetailSection.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import RxDataSources

enum SearchDetailSection {
    case info([SearchDetailSectionItem])
    case screenshot([SearchDetailSectionItem])
    case desc([SearchDetailSectionItem])
}

extension SearchDetailSection: SectionModelType {
    var items: [SearchDetailSectionItem] {
        switch self {
        case let .info(items): return items
        case let .screenshot(items): return items
        case let .desc(items): return items
        }
    }
    
    init(original: SearchDetailSection, items: [SearchDetailSectionItem]) {
        switch original {
        case .info: self = .info(items)
        case .screenshot: self = .screenshot(items)
        case .desc: self = .desc(items)
        }
    }
}

enum SearchDetailSectionItem {
    case infoItem(SearchItemCellReactor)
    case screenshotItem(SearchItemCellReactor)
    case descItem(SeachDetailDescCellReactor)
}
