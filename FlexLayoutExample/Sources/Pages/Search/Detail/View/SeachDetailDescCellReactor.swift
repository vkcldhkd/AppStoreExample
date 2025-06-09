//
//  SeachDetailDescCellReactor.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import ReactorKit
import RxSwift

final class SeachDetailDescCellReactor: Reactor {
    enum Action {
        case updateNumberOfLines
    }
    
    enum Mutation {
        case setNumberOfLines(Int)
    }
    
    struct State {
        var model: SearchResult
        var numberOfLines: Int
    }
    
    let initialState: State
    
    init(model: SearchResult) {
        defer { _ = self.state }
        self.initialState = State(
            model: model,
            numberOfLines: 4
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .updateNumberOfLines:
            let setNumberOfLines = Observable<Mutation>.just(.setNumberOfLines(0))
            return .concat(setNumberOfLines)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        switch mutation {
        case let .setNumberOfLines(lines):
            var newState = state
            newState.numberOfLines = lines
            return newState
        }
    }
}
