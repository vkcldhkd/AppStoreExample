//
//  SearchDetailViewController+TableView.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import UIKit
import RxSwift

extension SearchDetailViewController {
    // MARK: - BindTableView
    func bindTableView(reactor: Reactor) {
        // MARK: - Action
        self.adapter.tableView.rx.itemSelected(dataSource: self.adapter.dataSource)
            .observe(on: MainScheduler.asyncInstance)
            .withUnretained(self)
            .subscribe(onNext: {
                switch $0.1 {
                case let .descItem(cellReactor):
                    guard cellReactor.currentState.numberOfLines > 0 else { return }
                    let tableView = $0.0.adapter.tableView
                    UIView.performWithoutAnimation {
                        tableView.beginUpdates()
                        cellReactor.action.onNext(.updateNumberOfLines)
                        tableView.endUpdates()
                    }
                default:
                    return
                }
            })
            .disposed(by: self.disposeBag)
        
        // MARK: - State
        reactor.state.map { $0.section }
            .bind(to: self.adapter.tableView.rx.items(dataSource: self.adapter.dataSource))
            .disposed(by: self.disposeBag)
    }
}
