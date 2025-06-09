//
//  SearchMainViewController+TableView.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import UIKit
import RxSwift
//import RxOptional

extension SearchMainViewController {
    // MARK: - BindTableView
    func bindTableView(reactor: Reactor) {
        // MARK: - Delegate
        self.tableView.rx.setDelegate(self)
            .disposed(by: self.disposeBag)
        
        // MARK: - Action
//        self.tableView.rx.itemSelected(dataSource: self.dataSource)
//            .throttle(.milliseconds(600), scheduler: MainScheduler.asyncInstance)
//            .observe(on: MainScheduler.asyncInstance)
//            .subscribe(onNext: { [weak self] item in
//                self?.endEditing()
//                
//                switch item {
//                case let .searchItem(cellReactor):
//                    URLNavigatorHelper.shared.go(
//                        name: Pages.Search.detail,
//                        type: .push,
//                        context: [.model: cellReactor.currentState.model]
//                    )
//                case let .historyItem(cellReactor):
//                    guard !cellReactor.currentState.isEmpty else { return }
//                    self?.reactor?.action.onNext(.search(keyword: cellReactor.currentState.model))
//                    
//                default: 
//                    return
//                }
//            })
//            .disposed(by: self.disposeBag)
            
        
        // MARK: - State
        reactor.state.map { $0.section }
            .bind(to: self.tableView.rx.items(dataSource: self.dataSource))
            .disposed(by: self.disposeBag)
    }
}


//MARK: - UITableViewDelegate
extension SearchMainViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        guard let section = self.reactor?.currentState.section.first else { return nil }
        switch section {
        case .history: return SearchItemHeaderView(title: "최근 검색어")
        default: return nil
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        guard let section = self.reactor?.currentState.section.first else { return .zero }
        switch section {
        case .history: return 60
        default: return .zero
        }
    }
}
