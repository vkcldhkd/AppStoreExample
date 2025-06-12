//
//  SearchMainViewAdapter.swift
//  FlexLayoutExample
//
//  Created by HYUN SUNG on 6/10/25.
//

import UIKit
import ReusableKit
import RxDataSources
import RxSwift

final class SearchMainViewAdapter {
    // MARK: - Constants
    struct Reusable {
        static let listCell = ReusableCell<SearchItemCell>()
        static let emptyCell = ReusableCell<SearchEmptyCell>()
        static let historyCell = ReusableCell<SearchHistoryCell>()
    }
    
    // MARK: - UI
    var tableView: BaseTableView = BaseTableView().then {
        $0.register(Reusable.listCell)
        $0.register(Reusable.emptyCell)
        $0.register(Reusable.historyCell)
        $0.keyboardDismissMode = .onDrag
    }
    
    // MARK: - Rx
    private let disposeBag = DisposeBag()
    
    // MARK: - Properties
    var onItemSelected: ((SearchMainSectionItem) -> Void)?
    let dataSource: RxTableViewSectionedReloadDataSource<SearchMainSection>
    private static func dataSourceFactory() -> RxTableViewSectionedReloadDataSource<SearchMainSection> {
        return .init(
            configureCell: { dataSource, tableView, indexPath, sectionItem in
                switch sectionItem {
                case let .searchItem(cellReactor):
                    let cell = tableView.dequeue(Reusable.listCell, for: indexPath)
                    cell.reactor = cellReactor
                    return cell
                case let .searchEmptyItem(keyword):
                    let cell = tableView.dequeue(Reusable.emptyCell, for: indexPath)
                    cell.updateKeywordTitle(keyword: keyword)
                    return cell
                case let .historyItem(cellReactor):
                    let cell = tableView.dequeue(Reusable.historyCell, for: indexPath)
                    cell.reactor = cellReactor
                    return cell
                }
            }
        )
    }
    
    // MARK: - Initializing
    init() {
        self.dataSource = type(of: self).dataSourceFactory()
    }
}

extension SearchMainViewAdapter {
    func bindActions() {
        tableView.rx.itemSelected(dataSource: dataSource)
            .throttle(.milliseconds(600), scheduler: MainScheduler.asyncInstance)
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] in self?.onItemSelected?($0) })
            .disposed(by: self.disposeBag)
    }
}
