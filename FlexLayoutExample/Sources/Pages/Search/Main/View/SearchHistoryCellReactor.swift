//
//  SearchHistoryCellReactor.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import ReactorKit
import RxSwift

final class SearchHistoryCellReactor: Reactor {
    typealias Action = NoAction
    struct State {
        var model: String
        var isContains: Bool
        var isEmpty: Bool
    }
    
    let initialState: State
    
    init(
        model: String,
        isContains: Bool,
        isEmpty: Bool = false
    ) {
        defer { _ = self.state }
        self.initialState = State(
            model: model,
            isContains: isContains,
            isEmpty: isEmpty
        )
    }
}
