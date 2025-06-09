//
//  SearchScreenshotCellReactor.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import ReactorKit
import RxSwift

final class SearchScreenshotCellReactor: Reactor {
    typealias Action = NoAction
    
    struct State {
        var url: String
    }
    
    let initialState: State
    
    init(url: String) {
        defer { _ = self.state }
        self.initialState = State(url: url)
    }
}
