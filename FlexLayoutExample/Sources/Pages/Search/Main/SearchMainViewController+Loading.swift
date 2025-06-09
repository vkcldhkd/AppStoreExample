//
//  SearchMainViewController+Loading.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import UIKit
import RxSwift

extension SearchMainViewController {
    // MARK: - BindLoading
    func bindLoading(reactor: Reactor) {
        // MARK: - Action
        
        // MARK: - State
        reactor.state.map { $0.isLoading }
            .distinctUntilChanged()
            .bind(to: self.loadingView.rx.isAnimating)
            .disposed(by: self.disposeBag)
    }
}
